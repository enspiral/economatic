require 'active_record'
require 'account'
require 'money'
require 'user'

class Transaction < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :amount

  attr_accessible :source_account_id, :destination_account_id, :time, :creator_id, :source_account, :creator, :destination_account, :amount

  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'
  belongs_to :creator, class_name: 'User'

  scope :on_account, lambda {|account_id| 
    where("source_account_id = :account_id OR destination_account_id = :account_id",{account_id: account_id})
  }
end
