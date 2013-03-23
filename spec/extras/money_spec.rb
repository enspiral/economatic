require 'spec_helper'
require 'active_record'
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

describe MoneyAttribute do
  before(:all) do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define() do
      create_table :test_records do |t|
        t.decimal :numeric_test
      end
    end
  end
  after(:all) do
    ActiveRecord::Schema.define() { drop_table :test_records }
  end

  class TestRecord < ActiveRecord::Base
    include MoneyAttribute
    money_attribute :test
  end

  subject {TestRecord.new}
  it "has an attr_accesible" do
    subject.test.should == nil
  end

  it "saves money" do
    subject.test = Money.new(-20.0)
    subject.numeric_test.should == -20.0
  end

  it "loads minimum balance" do
  end

  it "sets sets money to nil" do
    subject.test = Money.new(-20.0)
    subject.test = nil
    subject.numeric_test.should == nil
    subject.test.should == nil
  end

end
