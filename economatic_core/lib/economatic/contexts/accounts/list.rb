require 'economatic/entities/bank'
require 'economatic/entities/user'
require 'economatic/roles/account_accessor'

module Economatic
  module Accounts
    class List < Playhouse::Context
      actor :bank, repository: Bank
      actor :viewer, repository: User, role: AccountAccessor

      def perform
        AccountTransactionCollection.cast_all accounts_scope
      end

      private

        def accounts_scope
          viewer.filter_accounts_by_viewable(bank.accounts).readonly
        end
    end
  end
end