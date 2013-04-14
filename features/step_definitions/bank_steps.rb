require 'bank_role'

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
