require 'account_role'
require 'bank_role'
require 'playhouse/role'

module Authorisable
  include Playhouse::Role

  def role_for_account account
    account_role_for_account(account) ||
      bank_role_for_account(account) ||
      NullAccountRole.new
  end

  private

    def account_role_for_account account
      AccountRole.where(account_id: account.id, user_id: id).first
    end

    def bank_role_for_account account
      BankRole.where(bank_id: account.bank_id, user_id: id).first
    end
end
