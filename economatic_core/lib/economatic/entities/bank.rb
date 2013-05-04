require 'active_record'
require 'economatic/entities/account'

module Economatic
  class Bank < ActiveRecord::Base
    has_many :accounts
  end
end