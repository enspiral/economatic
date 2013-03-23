require 'bank'
require "account"
require "user"
require "account_role"

require 'transfer_money_context'
require 'balance_enquiry_context'
require 'transaction_list_context'

CAPTURE_MONEY = Transform /^(\$)(\-?\d+)$/ do |currency_symbol, amount|
  Money.new(amount.to_f)
end

CAPTURE_ACCOUNT = Transform /^([^ ]*) account$/ do |account_identifier|
  account = @accounts[account_identifier]
  raise 'Account not found' if account.nil?
  account
end

Given /^a bank$/ do
  @bank = Bank.new
end

Given /^account ([^ ]*)/ do |account_identifier|
  @accounts ||= {}
  @accounts[account_identifier] = Account.create
end

Given /^a user ([^ ]*)$/ do |user_name|
  @users ||= {}
  @users[user_name] = @user = User.create(name: user_name)
end

Given /^a user ([^ ]*) who can operate (#{CAPTURE_ACCOUNT})$/ do |user_name, account|
  step("a user #{user_name}")
  AccountHolderRole.create!(user_id: @user.id, account_id: account.id)
end

Given /^a user ([^ ]*) who can not operate (#{CAPTURE_ACCOUNT})$/ do |user_name, account|
  step("a user #{user_name}")
end


When /^([^ ]*) transfers (#{CAPTURE_MONEY}) from (#{CAPTURE_ACCOUNT}) to (#{CAPTURE_ACCOUNT})$/ do |user_name, amount, source_account, destination_account|
  user = @users[user_name]
  context = TransferMoneyContext.new(
    bank: @bank,
    source_account: source_account,
    destination_account: destination_account,
    creator: user,
    amount: amount
  )
  context.call
end

When /^(.*) an error should be raised$/ do |original_step|
  expect {
    step(original_step)
  }.to raise_error
end

Then /^(#{CAPTURE_ACCOUNT}) has a balance of (#{CAPTURE_MONEY})$/ do |account, amount|
  context = BalanceEnquiryContext.new(
    account: account
  )
  context.call.should == amount
end

Then /^(#{CAPTURE_ACCOUNT}) has a (#{CAPTURE_MONEY}) transaction by ([^ ]*) (to|from) (#{CAPTURE_ACCOUNT}) in the transaction log$/ do |target_account, amount, user_name, to_from, actor_account|
  user = @users[user_name]

  context = TransactionListContext.new(
    account: target_account
  )
  last_transaction = context.call.last

  last_transaction.creator_id.should == user.id
  last_transaction.amount.should == amount
  if to_from == 'to'
    last_transaction.source_account_id.should == target_account.id
    last_transaction.destination_account_id.should == actor_account.id
  else
    last_transaction.source_account_id.should == actor_account.id
    last_transaction.destination_account_id.should == target_account.id
  end
end

Given /^(#{CAPTURE_ACCOUNT}) has an overdraft limit of (#{CAPTURE_MONEY})$/ do |account, amount|
  account.minimum_balance = amount
  account.save
end

