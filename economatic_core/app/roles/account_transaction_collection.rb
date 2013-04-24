require 'role'
require 'transfer'
require 'money'

module AccountTransactionCollection
  include Role

  SUM_COLUMN = :amount_cents

  actor_dependency :id
  actor_dependency :transactions

  def balance
    Money.new(non_pending.sum(SUM_COLUMN))
  end

  private

  def non_pending
    base_scope.where(pending: false)
  end

  def base_scope
    transactions
  end
end
