require 'active_record'
require 'bank'

class ExternalAccount < ActiveRecord::Base
  belongs_to :bank

  def minimum_balance
    nil
  end
end
