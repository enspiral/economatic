require 'playhouse/context'
require 'economatic/roles/approveable_transfer'
require 'economatic/entities/transfer_approval'

module Economatic
  class ApproveTransfer < Playhouse::Context
    actor :transfer, role: ApproveableTransfer, repository: Transfer
    actor :time
    actor :description
    actor :approver, repository: User

    def perform
      # TODO: wrap in database Transaction
      TransferApproval.create!(approval_arguments)
      transfer.approve_transactions!
    end

    def approval_arguments
      {
        time: time || Time.now,
        description: description,
        approver: approver,
        transfer: transfer
      }
    end
  end
end