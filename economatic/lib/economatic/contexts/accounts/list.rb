require 'playhouse/context'
require 'economatic/entities/bank'
require 'economatic/entities/user'
require 'economatic/roles/account_authorizer'

module Economatic
  module Accounts
    class List < Playhouse::Context
      actor :bank, repository: Bank
      actor :user, repository: User, role: AccountAuthorizer

      def perform
        AccountEntryCollection.cast_all accounts_scope
      end

      private

        def accounts_scope
          user.filter_accounts_by_viewable(bank.accounts).readonly
        end
    end
  end
end