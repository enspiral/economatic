require 'spec_helper'
require 'money'

describe Money do
  describe 'comparison' do
    it "equals other money with same amount" do
      Money.new(12.0).should == Money.new(12.0)
    end

    it "doesn't equal other money with different amount" do
      Money.new(12.0).should_not == Money.new(12.1)
    end
  end
end