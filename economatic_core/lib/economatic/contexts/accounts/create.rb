require 'playhouse/context'
require 'economatic/entities/bank'
require 'economatic/entities/account'

module Economatic
  module Accounts
    class Create < Playhouse::Context
      actor :bank, repository: Bank
      actor :name
      actor :description, optional: true

      def perform
        Account.create!(actors)
      end
    end
  end
end