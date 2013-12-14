require 'playhouse/support/files'
require 'playhouse/play'
require_all File.dirname(__FILE__), 'contexts/**/*.rb'

module Economatic
  class EconomaticPlay < Playhouse::Play
    context AccountBalanceEnquiry
    context ApproveTransfer
    context BankBalanceEnquiry
    context TransferMoney

    contexts_for Accounts

    def self.name
      'economatic'
    end

  end
end
