require 'spec_helper'
require 'economatic/roles/account_transaction_collection'

module Economatic
  describe AccountTransactionCollection do
    let(:actor) {Object.new.tap {|a| a.stub(:id => 1)}}
    let(:non_pending) {double(:non_pending)}
    let(:transactions) {double(:transactions)}
    subject { actor.extend AccountTransactionCollection }

    describe '#balance' do
      it 'returns sum of all non pending transactions for this account' do
        summable = double(:summable, sum: 2300)
        transactions.stub(:where).with(pending: false).and_return(summable)
        actor.stub(:transactions).and_return(transactions)

        subject.balance.should == Money.new(2300)
      end
    end
  end
end