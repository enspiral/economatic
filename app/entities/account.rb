require 'money'

class Account < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :minimum_balance
end
