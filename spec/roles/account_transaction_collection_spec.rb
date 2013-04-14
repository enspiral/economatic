require 'spec_helper'
require 'account_transaction_collection'

describe AccountTransactionCollection do
  let(:actor) {Object.new.tap {|a| a.stub!(:id => 1)}}
  let(:incoming_scope) {stub(:incoming_scope)}
  let(:outgoing_scope) {stub(:outgoing_scope)}
  subject { actor.extend AccountTransactionCollection }

  describe '#balance' do
    it 'returns incoming transactions minus outgoing transactions' do
      incoming_scope.stub(:sum).with(:amount_cents).and_return(30)
      outgoing_scope.stub(:sum).with(:amount_cents).and_return(20)

      Transaction.stub(:where).with(source_account_id: subject.id).and_return(outgoing_scope)
      Transaction.stub(:where).with(destination_account_id: subject.id).and_return(incoming_scope)

      subject.balance.should == Money.new(10)
    end
  end
end
