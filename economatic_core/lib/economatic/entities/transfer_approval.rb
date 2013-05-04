require 'active_record'
require 'economatic/entities/user'
require 'economatic/entities/transfer'

module Economatic
  class TransferApproval < ActiveRecord::Base
    belongs_to :approver, class_name: 'User'
    belongs_to :transfer
  end
end