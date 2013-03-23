require 'active_record'
require 'entity'
require 'account'
require 'money'
require 'user'

class Transaction < ActiveRecord::Base
  include Entity

  attr_accessible :source_account_id, :destination_account_id, :time, :amount, :creator_id

  belongs_to :source_account, class_name: :account
  belongs_to :destination_account, class_name: :account
  belongs_to :creator, class_name: :user

  scope :on_account, lambda {|account_id| 
    where("source_account_id = :account_id OR destination_account_id = :account_id",{account_id: account_id})
  }

  def self.with_account(account)

  end
end
