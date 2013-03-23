require 'active_record'
require 'entity'
require 'account'
require 'money'
require 'user'

class Transaction < ActiveRecord::Base
  include Entity

  attr_accessible :source_id, :destination_id, :time, :amount, :creator_id

  def self.with_account(account)
  end
end