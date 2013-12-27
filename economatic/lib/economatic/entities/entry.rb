require 'active_record'
require 'economatic/entities/account'
require 'economatic/entities/transaction'
require 'support/money_attribute'

module Economatic
  class Entry < ActiveRecord::Base
    include MoneyAttribute
    money_attribute :amount

    belongs_to :account
    belongs_to :transaction
  end
end