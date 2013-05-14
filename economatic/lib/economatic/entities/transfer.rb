require 'active_record'
require 'support/money_attribute'
require 'economatic/entities/account'
require 'economatic/entities/user'
require 'economatic/entities/transaction'

module Economatic
  class Transfer < ActiveRecord::Base
    include MoneyAttribute
    money_attribute :amount

    belongs_to :source_account, class_name: 'Account'
    belongs_to :destination_account, class_name: 'Account'
    belongs_to :creator, class_name: 'User'
    has_many   :transactions
  end
end