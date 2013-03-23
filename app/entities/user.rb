require 'active_record'

class User < ActiveRecord::Base
  attr_accessible :name
end
