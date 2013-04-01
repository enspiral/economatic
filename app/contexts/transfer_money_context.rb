require 'context'
require 'transaction'
require 'authorisable'
require 'transaction_source'
require 'account'
require 'user'
require 'bank'

class TransferMoneyContext < Context
  class CannotTransferMoney < Exception; end
  class NotAuthorizedToTransferMoney < CannotTransferMoney; end
  class AccountNotAbleToSendMoney < CannotTransferMoney; end

  actor :source_account, role: TransactionSource, repository: Account
  actor :destination_account, repository: Account
  actor :creator, role: Authorisable, repository: User
  actor :amount
  actor :time
  actor :bank, repository: Bank

  def transaction_arguments
    {
      source_account_id: source_account.id,
      destination_account_id: destination_account.id,
      creator_id: creator.id,
      amount: amount,
      time: time || Time.now
    }
  end

  def call
    role = creator.role_for source_account
    transaction = Transaction.new(transaction_arguments)

    raise NotAuthorizedToTransferMoney unless role.can_transfer_from?
    raise AccountNotAbleToSendMoney unless source_account.will_allow_transaction?(transaction)

    transaction.save!
  end
end
