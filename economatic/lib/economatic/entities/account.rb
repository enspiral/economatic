require 'active_record'
require 'support/money_attribute'
require 'economatic/entities/bank'
require 'economatic/entities/entry'

module Economatic
  class Account < ActiveRecord::Base
    include MoneyAttribute
    money_attribute :minimum_balance

    belongs_to :bank
    has_many :entries
    has_many :account_roles

    def external?
      false
    end
  end

  class ExternalAccount < Account
    def external?
      true
    end
  end
end