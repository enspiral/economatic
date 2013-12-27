require 'playhouse/context'
require 'economatic/entities/transaction'
require 'economatic/entities/account'
require 'economatic/entities/user'
require 'economatic/entities/bank'
require 'economatic/roles/account_authorizer'
require 'economatic/roles/transaction_source'
require 'economatic/roles/transaction_destination'
require 'economatic/composers/money_composer'

module Economatic
  class TransferMoney < Playhouse::Context
    class CannotTransferMoney < Exception; end
    class NotAuthorizedToTransfer < CannotTransferMoney; end
    class InsufficientFunds < CannotTransferMoney; end
    class InvalidTransactionDestination < CannotTransferMoney; end

    actor :source_account, role: TransactionSource, repository: Account
    actor :destination_account, role: TransactionDestination, repository: Account
    actor :creator, role: AccountAuthorizer, repository: User
    actor :amount, composer: MoneyComposer
    actor :time, optional: true
    actor :description, optional: true

    def transaction_arguments
      {
        creator_id: creator.id,
        time: time || Time.now,
        description: description
      }
    end

    def perform
      role = creator.role_for_account source_account

      raise NotAuthorizedToTransferMoney unless role.can_transfer_from?
      raise InsufficientFunds unless source_account.can_decrease_money?(amount)
      raise InvalidTransferDestination unless source_account.bank == destination_account.bank

      # TODO: Wrap this in a database transaction
      transaction = Transaction.create!(transaction_arguments)
      destination_account.increase_money!(amount, transaction)
      source_account.decrease_money!(amount, transaction)
    end
  end
end