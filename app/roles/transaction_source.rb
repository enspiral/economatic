require 'role'

module TransactionSource
  include Role

  actor_dependency :balance

  def will_allow_transaction?(transaction)
    true
  end
end