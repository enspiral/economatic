require 'transaction'
require 'authorisable'
require 'transaction_source'

class TransferMoneyContext
  class CannotTransferMoney < Exception; end
  class NotAuthorizedToTransferMoney < CannotTransferMoney; end
  class AccountNotAbleToSendMoney < CannotTransferMoney; end

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
      source_account: @source_account,
      destination_account: @destination_account,
      creator: @creator,
      amount: @amount,
      time: @time
    }
  end

  def call
    @time ||= Time.now
    role = @creator.role_for @source_account
    raise NotAuthorizedToTransferMoney unless role.can_transfer_from?
    transaction = Transaction.new(transaction_arguments)
    raise AccountNotAbleToSendMoney unless @source_account.will_allow_transaction?(transaction)
    transaction.save!
  end
end
