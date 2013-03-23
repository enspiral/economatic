require 'spec_helper'
require 'money'
require 'transfer_money_context'

describe TransferMoneyContext do
  let(:bank) { mock(:bank) }
  let(:account1) { mock(:account1) }
  let(:account2) { mock(:account2) }
  let(:user) { mock(:user) }
  let(:amount) { Money.new(12.0) }

  it "creates a transaction in the bank" do
    subject = TransferMoneyContext.new(
        bank: bank,
        source_account: account1,
        destination_account: account2,
        transferer: user,
        amount: amount
    )

    bank.should_receive(:add_transaction).with(
      source_account: account1,
      destination_account: account2,
      transferer: user,
      amount: amount
    )

    subject.call
  end
end