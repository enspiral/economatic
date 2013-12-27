require 'playhouse/role'

module Economatic
  module ApproveableTransfer
    include Playhouse::Role

    def approve_entries!
      entries.where(pending: true).each do |entry|
        entry.pending = false
        entry.save!
      end
    end
  end
end