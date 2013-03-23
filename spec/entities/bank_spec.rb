require 'spec_helper'
require 'bank'

describe Bank do
  let(:account) { mock(:account) }
  let(:details) { {'a' => 'b'} }

  describe '.add_transaction' do
    it "makes the transaction available when searching by account" do
      subject.add_transaction(details.merge(source: account))
      subject.transactions_for(account)
    end
  end
end