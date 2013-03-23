require 'bank'
require "account"
require "user"
require 'transfer_money_context'
require 'balance_enquiry_context'
require 'transaction_list_context'

CAPTURE_MONEY = Transform /^(\$)(\-?\d+)$/ do |currency_symbol, amount|
  Money.new(amount.to_f)
end

Given /^a bank$/ do
  @bank = Bank.new
end

Given /^account ([^ ]*)/ do |account_identifier|
  @accounts ||= {}
  @accounts[account_identifier] = Account.create
end

Given /^a user ([^ ]*) who can operate ([^ ]*)/ do |user_name, account_identifier|
  @users ||= {}
  @users[user_name] = User.create(name: user_name)
end

When /^([^ ]*) transfers (#{CAPTURE_MONEY}) from ([^ ]*) to ([^ ]*)/ do |user_name, amount, source_account_identifier, destination_account_identifier|
  source_account = @accounts[source_account_identifier]
  destination_account = @accounts[destination_account_identifier]
  user = @users[user_name]
  context = TransferMoneyContext.new(
    bank: @bank,
    source_account_id: source_account.id,
    destination_account_id: destination_account.id,
    creator_id: user.id,
    amount: amount
  )
  context.call
end

Then /^([^ ]*) account has (#{CAPTURE_MONEY})$/ do |account_identifier, amount|
  account = @accounts[account_identifier]

  context = BalanceEnquiryContext.new(
    account: account
  )
  context.call.should == amount
end

Then /^([^ ]*) has a (#{CAPTURE_MONEY}) transaction by ([^ ]*) (to|from) ([^ ]*) in the transaction log$/ do |target_account_identifier, amount, user_name, to_from, actor_account_identifier|
  target_account = @accounts[target_account_identifier]
  actor_account = @accounts[actor_account_identifier]
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
