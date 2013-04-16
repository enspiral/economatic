require 'active_record'
require 'user'
require 'transaction'

class TransactionApproval < ActiveRecord::Base
  belongs_to :approver, class_name: 'User'
  belongs_to :transaction
end