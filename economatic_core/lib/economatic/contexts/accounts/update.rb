require 'playhouse/context'
require 'economatic/entities/account'

module Economatic
  module Accounts
    class Update < Playhouse::Context
      actor :account, repository: Account
      actor :name, optional: true
      actor :description, optional: true

      def attributes
        actors_except :account
      end

      def perform
        account.update_attributes(attributes)
      end
    end
  end
end