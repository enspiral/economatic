require 'context'
require 'transaction_collection'
require 'account'

class TransactionListContext < Context
  actor :account, role: TransactionCollection, repository: Account

  def call
    account.transactions
  end
end
