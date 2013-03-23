require 'transaction'
require 'money'

module TransactionSummer
  #expects account_id
  def balance 
    total = incoming_transactions.sum(:amount) - outgoing_transactions.sum(:amount)
    Money.new(total)
  end

  private
  def outgoing_transactions
    Transaction.where(source_account_id: id)
  end

  def incoming_transactions
    Transaction.where(destination_account_id: id)
  end
end
