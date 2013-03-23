class AccountRole < ActiveRecord::Base
  attr_accessible :user_id, :account_id

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
