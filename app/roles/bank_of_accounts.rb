require 'role'

module BankOfAccounts
  include Role

  def balance
    raise NotImplementedError
  end
end