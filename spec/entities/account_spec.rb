require 'spec_helper'
require 'account'

describe Account do
  subject { Account.new('ABC') }

  context '.build_money' do
    it "constructs a money with the specified amount" do
      subject.build_money(12.3).amount.should == 12.3
    end
  end

  context '.balance' do
    it "starts as zero" do
      subject.balance.should == subject.build_money(0.0)
    end
  end
end