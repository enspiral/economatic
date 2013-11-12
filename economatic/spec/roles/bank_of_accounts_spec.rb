require 'spec_helper'
require 'economatic/roles/bank_of_accounts'

module Economatic
  describe BankOfAccounts do
    let(:accounts) {double(:accounts)}
    let(:actor) {Object.new.tap {|a| a.stub(:accounts => accounts)}}
    subject { actor.extend BankOfAccounts }

    describe '#external_accounts_balance' do
      it "returns zero if for an empty bank" do
        accounts.stub(:where).with(type: 'Economatic::ExternalAccount').and_return([])
        subject.external_accounts_balance.should == Money.new(0)
      end
    end
  end
end