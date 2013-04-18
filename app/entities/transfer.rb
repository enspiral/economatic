require 'active_record'
require 'account'
require 'money'
require 'user'
require 'variation'

class Transfer < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :amount

  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'
  belongs_to :creator, class_name: 'User'
  has_many   :variations
end
