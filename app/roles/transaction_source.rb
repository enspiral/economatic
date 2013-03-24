require 'role'
require 'transaction_collection'

module TransactionSource
  include Role

  actor_dependency :minimum_balance
  actor_dependency :balance, default_role: TransactionCollection

  def will_allow_transaction?(transaction)
    if minimum_balance
      balance - transaction.amount > minimum_balance
    else
      true
    end
  end
end