require 'context'
require 'account_transaction_collection'
require 'account'

class TransactionListContext < Context
  actor :account, role: AccountTransactionCollection, repository: Account

  def call
    account.transactions
  end
end
