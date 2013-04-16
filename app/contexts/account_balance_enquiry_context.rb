require 'context'
require 'account_variation_collection'
require 'account'

class AccountBalanceEnquiryContext < Context
  actor :account, role: AccountVariationCollection, repository: Account

  def call
    account.balance
  end
end
