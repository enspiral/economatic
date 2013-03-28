require 'transaction'
require 'authorisable'
require 'transaction_source'

class TransferMoneyContext < Context
  class CannotTransferMoney < Exception; end
  class NotAuthorizedToTransferMoney < CannotTransferMoney; end
  class AccountNotAbleToSendMoney < CannotTransferMoney; end

  # how about doing something like this?
  # actor :source_account, role: TransactionSource
  # actor :destination_account
  # actor :creator, role: Authorisable
  # actor :amount
  # actor :time
  # actor :bank

  def initialize(actors)
    @bank = actors[:bank]

    @source_account = TransactionSource.cast_actor(actors[:source_account])
    @destination_account = actors[:destination_account]
    @creator = Authorisable.cast_actor(actors[:creator])
    @amount = actors[:amount]
    @time = actors[:time]
  end

  def transaction_arguments
    {
      source_account_id: @source_account.id,
      destination_account_id: @destination_account.id,
      creator_id: @creator.id,
      amount: @amount,
      time: @time
    }
  end

  def call
    @time ||= Time.now
    role = @creator.role_for @source_account
    transaction = Transaction.new(transaction_arguments)

    raise NotAuthorizedToTransferMoney unless role.can_transfer_from?
    raise AccountNotAbleToSendMoney unless @source_account.will_allow_transaction?(transaction)

    transaction.save!
  end
end
