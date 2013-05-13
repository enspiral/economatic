require 'economatic/entities/bank'
require 'economatic/entities/user'

module Economatic
  module Accounts
    class List < Playhouse::Context
      actor :bank, repository: Bank
      actor :viewer, repository: User

      def perform
        # TODO: Filter this by bank and viewer
        Account.all
      end
    end
  end
end