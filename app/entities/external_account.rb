require 'active_record'
require 'bank'

class ExternalAccount < ActiveRecord::Base
  belongs_to :bank
end
