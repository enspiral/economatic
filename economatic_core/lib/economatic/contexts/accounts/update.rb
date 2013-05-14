require 'playhouse/context'
require 'economatic/entities/account'
require 'economatic/entities/user'
require 'economatic/roles/account_authorizer'

module Economatic
  module Accounts
    class Update < Playhouse::Context
      class NotAuthorizedToUpdateAccount < Exception; end

      actor :account, repository: Account
      actor :user, repository: User, role: AccountAuthorizer
      actor :name, optional: true
      actor :description, optional: true

      def attributes
        actors_except :account, :user
      end

      def perform
        raise NotAuthorizedToUpdateAccount unless user.can_update_account?(account)

        account.update_attributes(attributes)
      end
    end
  end
end