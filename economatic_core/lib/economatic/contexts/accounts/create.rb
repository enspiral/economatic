require 'playhouse/context'
require 'economatic/entities/bank'
require 'economatic/entities/account'

module Economatic
  module Accounts
    class Create < Playhouse::Context
      actor :bank, repository: Bank
      actor :name
      actor :description, optional: true

      def creation_arguments
        actors
      end

      def perform
        Account.create!(creation_arguments)
      end
    end
  end
end