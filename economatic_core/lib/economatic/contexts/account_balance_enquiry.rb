require 'playhouse/context'
require 'economatic/roles/account_transaction_collection'
require 'economatic/entities/account'

module Economatic
  class AccountBalanceEnquiry < Playhouse::Context
    actor :account, role: AccountTransactionCollection, repository: Account

    def call
      account.balance
    end
  end
end