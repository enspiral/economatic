require 'economatic/entities/account_role'
require 'economatic/entities/bank_role'
require 'playhouse/role'

module Economatic
  module AccountAuthorizer
    include Playhouse::Role

    def role_for_account(account)
      account_role_for_account(account) ||
          bank_role_for_account(account) ||
          NullAccountRole.new
    end

    def filter_accounts_by_viewable(accounts_scope)
      accounts_scope.joins(:account_roles).where("account_roles.user_id" => id).group("accounts.id")
    end

    def can_update_account?(account)
      role_for_account(account).can_update?
    end

    private

    def account_role_for_account account
      AccountRole.where(account_id: account.id, user_id: id).first
    end

    def bank_role_for_account account
      BankRole.where(bank_id: account.bank_id, user_id: id).first
    end
  end
end
