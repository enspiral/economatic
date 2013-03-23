require 'transaction'

class TransferMoneyContext
  #bank:
  #source_account:
  #destination_account:
  #creator:
  #amount:
  #time
  def initialize(actors)
    @bank = actors.delete(:bank)
    actors[:amount] = actors[:amount].amount
    @transaction_arguments = actors
  end

  def call
    @transaction_arguments[:time] ||= Time.now
    Transaction.create!(@transaction_arguments)
  end
end
