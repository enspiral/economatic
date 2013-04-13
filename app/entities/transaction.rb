require 'active_record'
require 'account'
require 'money'
require 'user'

class Transaction < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :amount

  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'
  belongs_to :creator, class_name: 'User'
end
