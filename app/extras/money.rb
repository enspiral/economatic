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
    def create options={}
    end
    def create! options={}
      if @money_attributes 

      end
      super options
    end

    def money_attribute attr_name
      @money_attributes ||= []
      @money_attributes << attr_name

      numeric_field = "numeric_#{attr_name}".to_sym
      attr_accessible numeric_field

      before_save "check_#{numeric_field}"

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

      define_method "check_#{numeric_field}" do
      end
    end
  end
end
