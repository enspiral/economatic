require 'role'
require 'account_variation_collection'

module BankOfAccounts
  include Role

  def external_accounts_balance
    external_accounts.sum do |account|
      AccountVariationCollection.cast_actor(account).balance
    end
  end

  def external_accounts
    accounts.where(type: 'ExternalAccount')
  end
end
