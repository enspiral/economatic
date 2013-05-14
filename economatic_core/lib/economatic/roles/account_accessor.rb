module Economatic
  module AccountAccessor
    include Playhouse::Role

    def filter_accounts_by_viewable(accounts_scope)
      accounts_scope.joins(:account_roles).group("accounts.id")
    end
  end
end
