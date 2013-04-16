require 'role'
require 'account_variation_collection'

module TransactionSource
  include Role

  actor_dependency :minimum_balance
  actor_dependency :bank
  actor_dependency :balance, default_role: AccountVariationCollection
  actor_dependency :id

  def can_decrease_money?(amount)
    if minimum_balance
      balance - amount > minimum_balance
    else
      true
    end
  end

  def decrease_money!(amount, transaction)
    Variation.create!(amount: -amount, transaction: transaction, account: self)
  end

  private

  def accounts_in_same_bank?(transaction)
    self.bank == transaction.destination_account.bank
  end
end