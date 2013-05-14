require 'playhouse/role'
require 'economatic/roles/account_transaction_collection'

module Economatic
  module TransferSource
    include Playhouse::Role

    actor_dependency :minimum_balance
    actor_dependency :bank
    actor_dependency :balance, default_role: AccountTransactionCollection
    actor_dependency :id

    def can_decrease_money?(amount)
      if minimum_balance
        balance - amount > minimum_balance
      else
        true
      end
    end

    def decrease_money!(amount, transfer)
      Transaction.create!(amount: -amount, transfer: transfer, account: self)
    end

    private

    def accounts_in_same_bank?(transfer)
      self.bank == transfer.destination_account.bank
    end
  end
end