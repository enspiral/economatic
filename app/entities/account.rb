require 'active_record'
require 'money_attribute'
require 'bank'

class Account < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :minimum_balance

  belongs_to :bank
end

class ExternalAccount < Account
end
