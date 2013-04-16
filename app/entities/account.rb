require 'active_record'
require 'money_attribute'
require 'bank'
require 'variation'

class Account < ActiveRecord::Base
  include MoneyAttribute
  money_attribute :minimum_balance

  belongs_to :bank
  has_many :variations

  def external?
    false
  end
end

class ExternalAccount < Account
  def external?
    true
  end
end
