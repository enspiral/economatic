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
  @accounts[account_identifier] = klass.create(bank: bank, name: account_identifier)
end

Given /^a user ([^ ]*) who can operate (#{CAPTURE_ACCOUNT})$/ do |user_name, account|
  step("a user #{user_name}")
  Economatic::AccountHolderRole.create!(user_id: @user.id, account_id: account.id)
end

Given /^a user ([^ ]*) who can not operate (#{CAPTURE_ACCOUNT})$/ do |user_name, account|
  step("a user #{user_name}")
end

Then /^(#{CAPTURE_ACCOUNT}) has a balance of (#{CAPTURE_MONEY})$/ do |account, amount|
  play.account_balance_enquiry(account: account).should == amount
end

Given /^(#{CAPTURE_ACCOUNT}) has an overdraft limit of (#{CAPTURE_MONEY})$/ do |account, amount|
  account.minimum_balance = amount
  account.save!
end

When /^([^ ]*) creates an account in ([^ ]*) with:$/ do |user_name, bank_name, table|
  user = users[user_name]
  bank = banks[bank_name]

  options = table.rows_hash.symbolize_keys
  options[:bank] = bank
  play.create_accounts(options)
end

Then /^([^ ]*)'s account list for ([^ ]*) should be:$/ do |user_name, bank_name, table|
  user = users[user_name]
  bank = banks[bank_name]

  result = play.list_accounts(bank: bank, user: user)
  expected = table.hashes

  result.each_with_index do |row, result_index|
    expected_row = expected[result_index]

    expected_row.each do |key, value|
      row.send(key).should == value
    end
  end
end

When /^([^ ]*) updates (#{CAPTURE_ACCOUNT}) with:$/ do |user_name, account, table|
  user = users[user_name]

  options = table.rows_hash.symbolize_keys
  options.merge!(account: account, user: user)
  play.update_accounts(options)
end

When /^([^ ]*) updates (#{CAPTURE_ACCOUNT})$/ do |user_name, account|
  user = users[user_name]

  options = {name: 'some default'}
  options.merge!(account: account, user: user)
  play.update_accounts(options)
end