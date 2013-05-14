require 'active_record'

module Economatic
  class AccountRole < ActiveRecord::Base
    abstract_class = true

    belongs_to :user
    belongs_to :account

    def can_transfer_from?
      false
    end

    def can_update?
      false
    end
  end

  class AccountHolderRole < AccountRole
    def can_transfer_from?
      true
    end

    def can_update?
      true
    end
  end

  class NullAccountRole < AccountRole
  end
end