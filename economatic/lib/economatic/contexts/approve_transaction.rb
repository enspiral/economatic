require 'playhouse/context'
require 'economatic/roles/approveable_transaction'
require 'economatic/entities/transaction_approval'

module Economatic
  class ApproveTransaction < Playhouse::Context
    actor :transaction, role: ApproveableTransaction, repository: Transaction
    actor :time, optional: true
    actor :description, optional: true
    actor :approver, repository: User

    def perform
      # TODO: wrap in database Transaction
      TransactionApproval.create!(approval_arguments)
      transaction.approve_entries!
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
end