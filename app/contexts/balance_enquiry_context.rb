require 'context'
require 'transaction_collection'
require 'account'

class BalanceEnquiryContext < Context
  actor :account, role: TransactionCollection, repository: Account

  def call
    account.balance
  end
end
