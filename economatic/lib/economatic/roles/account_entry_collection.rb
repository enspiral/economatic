require 'playhouse/role'
require 'economatic/entities/transaction'
require 'money'

module Economatic
  module AccountEntryCollection
    include Playhouse::Role

    SUM_COLUMN = :amount_cents

    actor_dependency :id
    actor_dependency :entries

    def balance
      Money.new(non_pending.sum(SUM_COLUMN))
    end

    private

    def non_pending
      base_scope.where(pending: false)
    end

    def base_scope
      entries
    end
  end
end