require 'active_record'

class BankRole < ActiveRecord::Base
  abstract_class = true

  belongs_to :user
  belongs_to :bank
end

class BankAdministratorRole < BankRole
end

class NullBankRole < BankRole
end
