require 'spec_helper'
require 'transaction_collection'

describe TransactionCollection do
  let(:actor) {Object.new.tap {|a| a.stub!(:id => 1)}}
  subject { actor.extend TransactionCollection }

  describe 'balance' do
    it 'returns incoming transactions - outgoing transactions' do
      incoming_scope = stub(:incoming_scope)
      incoming_scope.stub(:sum).with(:amount_cents).and_return(30)
      outgoing_scope = stub(:outgoing_scope)
      outgoing_scope.stub(:sum).with(:amount_cents).and_return(20)

      Transaction.stub(:where).with(source_account_id: subject.id).and_return(outgoing_scope)
      Transaction.stub(:where).with(destination_account_id: subject.id).and_return(incoming_scope)

      subject.balance.should == Money.new(10)
    end
  end
end
