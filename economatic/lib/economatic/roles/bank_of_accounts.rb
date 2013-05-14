require 'playhouse/role'
require 'economatic/roles/account_transaction_collection'

module Economatic
  module BankOfAccounts
    include Playhouse::Role

    def external_accounts_balance
      external_accounts.sum do |account|
        AccountTransactionCollection.cast_actor(account).balance
      end
    end

    def external_accounts
      accounts.where(type: 'Economatic::ExternalAccount')
    end
  end
end