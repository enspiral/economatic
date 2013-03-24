require 'role'
require 'transaction_collection'

module TransactionSource
  include Role

  actor_dependency :minimum_balance
  actor_dependency :bank
  actor_dependency :balance, default_role: TransactionCollection

  def will_allow_transaction?(transaction)
    minimum_balance_allows?(transaction) && accounts_in_same_bank?(transaction)
  end

  private

  def accounts_in_same_bank?(transaction)
    self.bank == transaction.destination_account.bank
  end

  def minimum_balance_allows?(transaction)
    if minimum_balance
      balance - transaction.amount > minimum_balance
    else
      true
    end
  end

end