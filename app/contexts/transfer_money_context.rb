class TransferMoneyContext
  #bank:
  #source_account: source_account,
  #destination_account: destination_account,
  #transferer: user,
  #amount: amount
  def initialize(actors)
    @bank = actors.delete(:bank)
    @transaction_arguments = actors
  end

  def call
    @bank.add_transaction(@transaction_arguments)
  end
end