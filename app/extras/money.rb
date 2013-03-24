class Money
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def ==(other)
    @amount.to_f == other.amount.to_f
  end
end

module MoneyAttribute
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def money_attribute attr_name
      numeric_field = "numeric_#{attr_name}".to_sym

      define_method attr_name do
        Money.new(read_attribute(numeric_field)) if read_attribute(numeric_field)
      end

      define_method "#{attr_name}=" do |money|
        if money.nil?
          write_attribute(numeric_field, nil)
        else
          write_attribute(numeric_field, money.amount)
        end
      end
    end
  end
end
