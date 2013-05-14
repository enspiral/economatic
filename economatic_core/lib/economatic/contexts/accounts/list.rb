require 'economatic/entities/bank'
require 'economatic/entities/user'

module Economatic
  module Accounts
    class List < Playhouse::Context
      actor :bank, repository: Bank
      actor :viewer, repository: User

      def perform
        # TODO: Filter this by viewer
        AccountTransactionCollection.cast_all accounts_scope
      end

      private

        def accounts_scope
          Account.where(bank_id: bank.id)
        end
    end
  end
end