require 'spec_helper'
require 'timecop'
require 'money'
require 'transfer_money_context'

describe TransferMoneyContext do
  let(:bank) { mock(:bank) }
  let(:account1) { mock(:account1) }
  let(:account2) { mock(:account2) }
  let(:user) { mock(:user) }
  let(:amount) { Money.new(12.0) }

  it "save a transaction entity" do
    now = Time.now
    Timecop.freeze(now) do
      subject = TransferMoneyContext.new(
          bank: bank,
          source_account: account1,
          destination_account: account2,
          creator: user,
          amount: amount
      )

      Transaction.should_receive(:create!).with(
          source_account: account1,
          destination_account: account2,
          creator: user,
          amount: amount,
          time: now
      )

      subject.call
    end
  end
end
