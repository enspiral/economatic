require 'money'
require 'bank'

class Account < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :minimum_balance

  belongs_to :bank
end
