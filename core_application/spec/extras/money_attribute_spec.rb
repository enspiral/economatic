require 'spec_helper'
require 'money_attribute'
require 'active_record'

describe MoneyAttribute do
  before(:all) do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define() do
      create_table :test_records do |t|
        t.decimal :amount_cents
      end
    end
  end
  after(:all) do
    ActiveRecord::Schema.define() { drop_table :test_records }
  end

  class TestRecord < ActiveRecord::Base
    include MoneyAttribute
    money_attribute :amount
  end

  subject {TestRecord.new}
  it "has an attr_accesible" do
    subject.amount.should == nil
  end

  it "saves money" do
    subject.amount = Money.new(-20)
    subject.amount_cents.should == -20
  end

  it "sets sets money to nil" do
    subject.amount = Money.new(-20)
    subject.amount = nil
    subject.amount_cents.should == nil
    subject.amount.should == nil
  end

  it "creates object successfully" do
    record = TestRecord.create!(amount: Money.new(2))
    record.amount.should == Money.new(2)
    record.amount_cents.should == 2
  end

  it "instantiates object successfully" do
    record = TestRecord.new(amount: Money.new(2))
    record.amount.should == Money.new(2)
    record.amount_cents.should == 2
  end

end
