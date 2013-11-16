module Economatic
  class MoneyComposer
    def self.compose(amount)
      Money.new(amount.gsub(',', '').to_f)
    end
  end
end