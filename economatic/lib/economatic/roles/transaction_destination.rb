require 'playhouse/role'

module Economatic
  module TransactionDestination
    include Playhouse::Role

    actor_dependency :id

    def increase_money!(amount, transaction)
      Entry.create!(amount: amount, transaction: transaction, account: self, pending: external?)
    end
  end
end