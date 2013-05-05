require 'economatic/entities/bank'
require 'economatic/entities/account'
require 'economatic/entities/user'
require 'economatic/entities/account_role'

require 'economatic/contexts/transfer_money'
require 'economatic/contexts/account_balance_enquiry'

CAPTURE_MONEY = Transform /^(\$)(\-?[\d\.\,]+)$/ do |currency_symbol, amount|
  Money.new(amount.gsub(',', '').to_f)
end

CAPTURE_ACCOUNT = Transform /^([^ ]*) account$/ do |account_identifier|
  @accounts[account_identifier] || (raise 'Account not found')
end

CAPTURE_WITH_DESCRIPTION = Transform /^( ?with description "([^"]*)")?$/ do |unused, description|
  description
end

Given /^(external )?account ([^ ]*) in ([^ ]+)$/ do |is_external, account_identifier, bank_name|
  bank = banks[bank_name]
  bank.should_not be_nil

  klass = is_external ? Economatic::ExternalAccount : Economatic::Account

  @accounts ||= {}
  @accounts[account_identifier] = klass.create(bank: bank)
end

Given /^a user ([^ ]*)$/ do |user_name|
  @users ||= {}
  @users[user_name] = @user = Economatic::User.create(name: user_name)
end

Given /^a user ([^ ]*) who can operate (#{CAPTURE_ACCOUNT})$/ do |user_name, account|
  step("a user #{user_name}")
  Economatic::AccountHolderRole.create!(user_id: @user.id, account_id: account.id)
end

Given /^a user ([^ ]*) who can not operate (#{CAPTURE_ACCOUNT})$/ do |user_name, account|
  step("a user #{user_name}")
end

Then /^(#{CAPTURE_ACCOUNT}) has a balance of (#{CAPTURE_MONEY})$/ do |account, amount|
  context = Economatic::AccountBalanceEnquiry.new(account: account)
  context.call.should == amount
end

Given /^(#{CAPTURE_ACCOUNT}) has an overdraft limit of (#{CAPTURE_MONEY})$/ do |account, amount|
  account.minimum_balance = amount
  account.save!
end

