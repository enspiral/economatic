require 'active_record'
require 'account'
require 'money'
require 'transfer'

class Transaction < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :amount

  belongs_to :account
  belongs_to :transfer
end