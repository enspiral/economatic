require 'playhouse/context'
require 'economatic/roles/bank_of_accounts'

module Economatic
  class BankBalanceEnquiry < Playhouse::Context
    actor :bank, role: BankOfAccounts, repository: Bank

    def perform
      -bank.external_accounts_balance
    end
  end
end