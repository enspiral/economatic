require 'economatic/entities/bank_role'
require 'economatic/contexts/bank_balance_enquiry'

CAPTURE_BANK = Transform /^([^ ]*) bank/ do |identifier|
  bank = @banks[identifier]
  raise 'Bank not found' if bank.nil?
  bank
end

def banks
  @banks ||= {}
end

Given /^a bank ([^ ]+)$/ do |bank_name|
  banks[bank_name] = Economatic::Bank.create!
end

Given /^a user ([^ ]*) who can administer (#{CAPTURE_BANK})$/ do |user_name, bank|
  step("a user #{user_name}")
  Economatic::BankAdministratorRole.create!(user_id: @user.id, bank_id: bank.id)
end

Then /^Total money in (#{CAPTURE_BANK}) is (#{CAPTURE_MONEY})$/ do |bank, expected_balance|
  Economatic::BankBalanceEnquiry.new(bank: bank).call.should == expected_balance
end

Then /^(#{CAPTURE_BANK}) has pending transfers totaling (#{CAPTURE_MONEY})$/ do |bank, amount|
  total_cents = Economatic::Transaction.joins(:account).where(:pending => true, "accounts.bank_id" => bank.id).sum(:amount_cents)
  total = Money.new(total_cents)
  total.should == amount
end