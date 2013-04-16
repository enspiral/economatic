require 'bank'
require "account"
require "user"
require "account_role"

require 'transfer_money_context'
require 'account_balance_enquiry_context'

CAPTURE_MONEY = Transform /^(\$)(\-?[\d\.\,]+)$/ do |currency_symbol, amount|
  Money.new(amount.gsub(',', '').to_f)
end

CAPTURE_ACCOUNT = Transform /^([^ ]*) account$/ do |account_identifier|
  account = @accounts[account_identifier]
  raise 'Account not found' if account.nil?
  account
end

CAPTURE_WITH_DESCRIPTION = Transform /^( ?with description "([^"]*)")?$/ do |unused, description|
  description
end

Given /^(external )?account ([^ ]*) in ([^ ]+)$/ do |is_external, account_identifier, bank_name|
  bank = banks[bank_name]
  bank.should_not be_nil

  klass = is_external ? ExternalAccount : Account

  @accounts ||= {}
  @accounts[account_identifier] = klass.create(bank: bank)
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

When /^([^ ]*) transfers (#{CAPTURE_MONEY}) from (#{CAPTURE_ACCOUNT}) to (#{CAPTURE_ACCOUNT})(#{CAPTURE_WITH_DESCRIPTION})$/ do |user_name, amount, source_account, destination_account, description|
  user = @users[user_name]
  context = TransferMoneyContext.new(
    bank: @bank,
    source_account: source_account,
    destination_account: destination_account,
    creator: user,
    amount: amount,
    description: description
  )
  context.call
end

Then /^(#{CAPTURE_ACCOUNT}) has a balance of (#{CAPTURE_MONEY})$/ do |account, amount|
  context = AccountBalanceEnquiryContext.new(account: account)
  context.call.should == amount
end

Then /^(#{CAPTURE_ACCOUNT}) has a (#{CAPTURE_MONEY}) transaction by ([^ ]*) (to|from) (#{CAPTURE_ACCOUNT})(#{CAPTURE_WITH_DESCRIPTION}) in the transaction log$/ do |target_account, amount, user_name, to_from, actor_account, description|
  user = @users[user_name]

  # This is really complex logic to be in a test. If we need the app API to perform
  # this for us, it should be in a context (and it should be way nicer code).
  # If we don't need the API to perform this, why are we testing it?

  if to_from == 'to'
    source_account = target_account
    destination_account = actor_account
  else
    source_account = actor_account
    destination_account = target_account
  end

  source_variation_scope = source_account.variations.where(amount_cents: -amount.cents)
  source_variation_scope.should exist

  destination_variation_scope = destination_account.variations.where(amount_cents: amount.cents)
  destination_variation_scope.should exist

  valid_transaction_ids = source_variation_scope.map(&:transaction_id) & destination_variation_scope.map(&:transaction_id)

  transaction_scope = Transaction.where(id: valid_transaction_ids, creator_id: user.id)
  transaction_scope = transaction_scope.where(description: description) unless description.blank?
  transaction_scope.should exist
end

Given /^(#{CAPTURE_ACCOUNT}) has an overdraft limit of (#{CAPTURE_MONEY})$/ do |account, amount|
  account.minimum_balance = amount
  account.save!
end

