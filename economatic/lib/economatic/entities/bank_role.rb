require 'active_record'

module Economatic
  class BankRole < ActiveRecord::Base
    abstract_class = true

    belongs_to :user
    belongs_to :bank
  end

  class BankAdministratorRole < BankRole
    def can_transfer_from?
      true
    end
  end
end