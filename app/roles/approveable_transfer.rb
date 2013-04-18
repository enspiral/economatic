require 'role'

module ApproveableTransfer
  include Role

  def approve_transactions!
    transactions.where(pending: true).each do |transaction|
      transaction.pending = false
      transaction.save!
    end
  end
end