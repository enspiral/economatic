require 'context'
require 'approveable_transfer'
require 'transfer_approval'

class ApproveTransferContext < Context
  actor :transfer, role: ApproveableTransfer, repository: Transfer
  actor :time
  actor :description
  actor :approver, repository: User

  def call
    # TODO: wrap in database Transaction
    TransferApproval.create!(approval_arguments)
    transfer.approve_variations!
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
