require 'playhouse/role'
require 'economatic/entities/transfer'
require 'money'

module Economatic
  module AccountTransactionCollection
    include Playhouse::Role

    SUM_COLUMN = :amount_cents

    actor_dependency :id
    actor_dependency :transactions

    def balance
      Money.new(non_pending.sum(SUM_COLUMN))
    end

    private

    def non_pending
      base_scope.where(pending: false)
    end

    def base_scope
      transactions
    end
  end
end