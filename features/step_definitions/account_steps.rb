require 'bank'
require "account"
require "user"
require 'transfer_money_context'
require 'balance_enquiry_context'

Given /^a bank$/ do
  @bank = Bank.new
end

Given /^account ([^ ]*)/ do |account_identifier|
  @accounts ||= {}
  @accounts[account_identifier] = Account.new(account_identifier)
end

Given /^a user ([^ ]*) who can operate ([^ ]*)/ do |user_name, account_identifier|
  @users ||= {}
  @users[user_name] = User.new(name: user_name)
end

When /^([^ ]*) transfers (\d+) from ([^ ]*) to ([^ ]*)/ do |user_name, amount, source_account_identifier, destination_account_identifier|
  source_account = @accounts[source_account_identifier]
  destination_account = @accounts[destination_account_identifier]
  user = @users[user_name]

  context = TransferMoneyContext.new(
    bank: @bank,
    source_account: source_account,
    destination_account: destination_account,
    transferer: user,
    amount: amount
  )
  context.call
end

Then /^([^ ]*) account has (\-?\d+)$/ do |account_identifier, amount|
  account = @accounts[account_identifier]

  context = BalanceEnquiryContext.new(
    account: account
  )
  context.call.amount.should == amount.to_f
end