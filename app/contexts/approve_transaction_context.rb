require 'context'
require 'approveable_transaction'
require 'transaction_approval'

class ApproveTransactionContext < Context
  actor :transaction, role: ApproveableTransaction, repository: Transaction
  actor :time
  actor :description
  actor :approver, repository: User

  def call
    # TODO: wrap in database Transaction
    TransactionApproval.create!(approval_arguments)
    transaction.approve_variations!
  end

  def approval_arguments
    {
      time: time || Time.now,
      description: description,
      approver: approver,
      transaction: transaction
    }
  end
end
