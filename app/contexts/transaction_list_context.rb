require 'context'
require 'transaction_collection'

class TransactionListContext < Context
  actor :account, role: TransactionCollection

  def call
    account.transactions
  end
end
