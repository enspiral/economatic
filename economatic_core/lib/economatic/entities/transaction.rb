require 'active_record'
require 'economatic/entities/account'
require 'economatic/entities/transfer'
require 'support/money_attribute'

module Economatic
  class Transaction < ActiveRecord::Base
    include MoneyAttribute
    money_attribute :amount

    belongs_to :account
    belongs_to :transfer
  end
end