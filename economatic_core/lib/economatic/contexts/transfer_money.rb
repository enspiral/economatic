require 'playhouse/context'
require 'economatic/entities/transfer'
require 'economatic/entities/account'
require 'economatic/entities/user'
require 'economatic/entities/bank'
require 'economatic/roles/authorisable'
require 'economatic/roles/transfer_source'
require 'economatic/roles/transfer_destination'
require 'economatic/composers/money_composer'

module Economatic
  class TransferMoney < Playhouse::Context
    class CannotTransferMoney < Exception; end
    class NotAuthorizedToTransferMoney < CannotTransferMoney; end
    class InsufficientFunds < CannotTransferMoney; end
    class InvalidTransferDestination < CannotTransferMoney; end

    actor :source_account, role: TransferSource, repository: Account
    actor :destination_account, role: TransferDestination, repository: Account
    actor :creator, role: Authorisable, repository: User
    actor :amount, composer: MoneyComposer
    actor :time
    actor :bank, repository: Bank
    actor :description

    def transfer_arguments
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
      transfer = Transfer.create!(transfer_arguments)
      destination_account.increase_money!(amount, transfer)
      source_account.decrease_money!(amount, transfer)
    end
  end
end