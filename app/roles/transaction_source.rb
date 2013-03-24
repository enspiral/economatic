require 'role'

module TransactionSource
  include Role

  actor_dependency :balance, default_role: TransactionCollection

  def will_allow_transaction?(transaction)
    true
  end
end