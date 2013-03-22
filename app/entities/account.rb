require 'money'

class Account
  def initialize(account_identifier)

  end

  def balance
    build_money(0.0)
  end

  def build_money(amount)
    Money.new(amount)
  end
end