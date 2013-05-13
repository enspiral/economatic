require 'playhouse/support/files'
require 'playhouse/api'
require_all File.dirname(__FILE__), 'contexts/**/*.rb'

module Economatic
  class API < Playhouse::API
    context AccountBalanceEnquiry
    context ApproveTransfer
    context BankBalanceEnquiry
    context TransferMoney
    context Accounts::Create
    context Accounts::List
  end
end