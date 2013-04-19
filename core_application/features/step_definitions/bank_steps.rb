require 'bank_role'
require 'bank_balance_enquiry_context'

CAPTURE_BANK = Transform /^([^ ]*) bank/ do |identifier|
  bank = @banks[identifier]
  raise 'Bank not found' if bank.nil?
  bank
end

def banks
  @banks ||= {}
end

Given /^a bank ([^ ]+)$/ do |bank_name|
  banks[bank_name] = Bank.create!
end

Given /^a user ([^ ]*) who can administer (#{CAPTURE_BANK})$/ do |user_name, bank|
  step("a user #{user_name}")
  BankAdministratorRole.create!(user_id: @user.id, bank_id: bank.id)
end

Then /^Total money in (#{CAPTURE_BANK}) is (#{CAPTURE_MONEY})$/ do |bank, expected_balance|
  BankBalanceEnquiryContext.new(bank: bank).call.should == expected_balance
end

Then /^(#{CAPTURE_BANK}) has pending transfers totaling (#{CAPTURE_MONEY})$/ do |bank, amount|
  total_cents = Transaction.joins(:account).where(:pending => true, "accounts.bank_id" => bank.id).sum(:amount_cents)
  total = Money.new(total_cents)
  total.should == amount
end