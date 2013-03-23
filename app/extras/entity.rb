require 'virtus'

module Entity
  def self.included(base)
    base.send :include, Virtus
    base.extend ClassMethods
  end

  def save
  end

  def save!
  end

  module ClassMethods
    def create!(params)
      entity = self.new(params)
      entity.save!
      entity
    end
  end
end