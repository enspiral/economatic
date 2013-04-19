require 'context'
require 'account_transaction_collection'
require 'account'

class AccountBalanceEnquiryContext < Context
  actor :account, role: AccountTransactionCollection, repository: Account

  def call
    account.balance
  end
end
