require 'context'
require 'transaction_collection'

class BalanceEnquiryContext < Context
  actor :account, role: TransactionCollection

  def call
    account.balance
  end
end
