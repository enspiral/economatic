require 'role'

module TransactionDestination
  include Role

  actor_dependency :id

  def increase_money!(amount, transaction)
    Variation.create!(amount: amount, transaction: transaction, account: self, pending: external?)
  end
end