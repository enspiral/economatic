require 'active_record'

class AccountRole < ActiveRecord::Base
  abstract_class = true

  belongs_to :user
  belongs_to :account

  def can_transfer_from?
    false
  end
end

class AccountHolderRole < AccountRole
  def can_transfer_from?
    true
  end
end

class NullAccountRole < AccountRole
end
