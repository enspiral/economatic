require 'transaction'
require 'authorisable'
require 'transaction_collection'

class TransferMoneyContext
  class CannotTransferMoney < Exception; end
  class NotAuthorizedToTransferMoney < CannotTransferMoney; end
  class AccountNotAbleToSendMoney < CannotTransferMoney; end

  def initialize(actors)
    @bank = actors[:bank]

    #CastingCouch.cast(@source_account).as(TransactionSource)

    #@source_account.cast_as(TransactionSource)

    TransactionSource.cast_actor(@source_account)

    @source_account = actors[:source_account].cast_as(TransactionSource)
    @destination_account = actors[:destination_account]
    @creator = actors[:creator].extend Authorisable
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
