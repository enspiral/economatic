require 'transaction_summer'

class BalanceEnquiryContext
  def initialize(actors)
    @account = actors[:account]
    @account.extend TransactionSummer
  end

  def call
    @account.balance
  end
end
