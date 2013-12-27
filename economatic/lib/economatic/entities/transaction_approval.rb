require 'active_record'
require 'economatic/entities/user'
require 'economatic/entities/transaction'

module Economatic
  class TransactionApproval < ActiveRecord::Base
    belongs_to :approver, class_name: 'User'
    belongs_to :transaction
  end
end