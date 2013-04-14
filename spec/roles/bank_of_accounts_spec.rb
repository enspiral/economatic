require 'spec_helper'
require 'bank_of_accounts'

describe BankOfAccounts do
  let(:accounts) {mock(:accounts)}
  let(:actor) {Object.new.tap {|a| a.stub!(:accounts => accounts)}}
  subject { actor.extend BankOfAccounts }

  describe '#external_accounts_balance' do
    it "returns zero if for an empty bank" do
      accounts.stub!(:where).with(type: 'ExternalAccount').and_return([])
      subject.external_accounts_balance.should == Money.new(0)
    end
  end
end