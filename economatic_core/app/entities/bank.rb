require 'active_record'
require 'account'

class Bank < ActiveRecord::Base
  has_many :accounts
end