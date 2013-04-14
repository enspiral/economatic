require 'context'
require 'bank_of_accounts'

class BankBalanceEnquiryContext < Context
  actor :bank, role: BankOfAccounts, repository: Bank

  def call
    -bank.external_accounts_balance
  end
end
