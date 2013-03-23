require 'money'
require 'transaction'

class BalanceEnquiryContext
  def initialize(actors)
    @account = actors[:account]
  end

  def call
    Transaction.with_account(@account).map(&:amount).sum
  end
end