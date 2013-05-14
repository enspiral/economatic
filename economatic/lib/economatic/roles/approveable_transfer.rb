require 'playhouse/role'

module Economatic
  module ApproveableTransfer
    include Playhouse::Role

    def approve_transactions!
      transactions.where(pending: true).each do |transaction|
        transaction.pending = false
        transaction.save!
      end
    end
  end
end