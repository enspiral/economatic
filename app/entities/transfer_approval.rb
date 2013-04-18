require 'active_record'
require 'user'
require 'transfer'

class TransferApproval < ActiveRecord::Base
  belongs_to :approver, class_name: 'User'
  belongs_to :transfer
end