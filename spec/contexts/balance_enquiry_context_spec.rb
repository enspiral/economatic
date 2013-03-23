require 'spec_helper'
require 'balance_enquiry_context'

describe BalanceEnquiryContext do
  let(:account) { mock(:account) }
  let(:other) { mock(:other_account) }
  let(:user) { mock(:user) }
  subject { BalanceEnquiryContext.new(account: account) }

  it "returns zero if no transactions refer to this account" do
    subject.call.amount.should == 0.0
  end

  it "sums transactions into this account" do
    Transaction.create!(source: other, destination: account, amount: 10.0, user: user)
    Transaction.create!(source: other, destination: account, amount: 15.0, user: user)

    subject.call.amount.should == 25.0
  end
end