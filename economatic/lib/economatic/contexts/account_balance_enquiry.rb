require 'playhouse/context'
require 'economatic/roles/account_entry_collection'
require 'economatic/entities/account'

module Economatic
  class AccountBalanceEnquiry < Playhouse::Context
    actor :account, role: AccountEntryCollection, repository: Account

    def perform
      account.balance
    end
  end
end