require 'transaction_collection'
class TransactionListContext
  def initialize(actors)
    @account = actors[:account]
    @account.extend TransactionCollection
  end

  def call
    @account.transactions
  end
end
