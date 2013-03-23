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
      attr_accessible numeric_field

      define_method attr_name do
        Money.new(send(numeric_field)) if send(numeric_field)
      end

      define_method "#{attr_name}=" do |money|
        if money.nil?
          send("#{numeric_field}=", nil)
        else
          send("#{numeric_field}=", money.amount)
        end
      end
    end
  end
end
