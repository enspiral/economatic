require 'entity'
require 'account'
require 'money'
require 'user'

class Transaction
  include Entity

  attribute :source, Account
  attribute :destination, Account
  attribute :time, DateTime
  attribute :amount, Money
  attribute :creator, User
end