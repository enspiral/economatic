require 'transaction_collection'

class BalanceEnquiryContext
  def initialize(actors)
    @account = TransactionCollection.cast_actor(actors[:account])
  end

  def call
    @account.balance
  end
end
