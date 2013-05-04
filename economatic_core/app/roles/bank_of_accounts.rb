require 'playhouse/role'
require 'account_transaction_collection'

module BankOfAccounts
  include Playhouse::Role

  def external_accounts_balance
    external_accounts.sum do |account|
      AccountTransactionCollection.cast_actor(account).balance
    end
  end

  def external_accounts
    accounts.where(type: 'ExternalAccount')
  end
end
