require 'context'
require 'transaction'
require 'authorisable'
require 'transaction_source'
require 'transaction_destination'
require 'account'
require 'user'
require 'bank'
require 'money_composer'

class TransferMoneyContext < Context
  class CannotTransferMoney < Exception; end
  class NotAuthorizedToTransferMoney < CannotTransferMoney; end
  class InsufficientFunds < CannotTransferMoney; end
  class InvalidTransactionDestination < CannotTransferMoney; end

  actor :source_account, role: TransactionSource, repository: Account
  actor :destination_account, role: TransactionDestination, repository: Account
  actor :creator, role: Authorisable, repository: User
  actor :amount, composer: MoneyComposer
  actor :time
  actor :bank, repository: Bank
  actor :description

  def transaction_arguments
    {
      creator_id: creator.id,
      time: time || Time.now,
      description: description
    }
  end

  def call
    role = creator.role_for_account source_account

    raise NotAuthorizedToTransferMoney unless role.can_transfer_from?
    raise InsufficientFunds unless source_account.can_decrease_money?(amount)
    raise InvalidTransactionDestination unless source_account.bank == destination_account.bank

    # TODO: Wrap this in a database transaction
    transaction = Transaction.create!(transaction_arguments)
    destination_account.increase_money!(amount, transaction)
    source_account.decrease_money!(amount, transaction)
  end
end
