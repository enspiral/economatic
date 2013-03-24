require 'spec_helper'
require 'timecop'
require 'money'
require 'transfer_money_context'

describe TransferMoneyContext do
  let(:bank) { mock(:bank) }
  let(:account1) { mock(:account1, minimum_balance: nil) }
  let(:account2) { mock(:account2) }
  let(:user) { mock(:user) }
  let(:amount) { Money.new(12.0) }

  subject {
    TransferMoneyContext.new(
        bank: bank,
        source_account: account1,
        destination_account: account2,
        creator: user,
        amount: amount
    )
  }

  context "user with holder role" do
    before do
      mock_user_rights user, account1, can_transfer_from?: true
    end

    it "saves a transaction entity" do
      now = Time.now
      Timecop.freeze(now) do

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

  context "without right" do
    before do
      mock_user_rights user, account1, can_transfer_from?: false
    end

    it "raises error" do
      expect {
        subject.call
      }.to raise_error
    end

  end

  def mock_user_rights user, account, rights={}
    account_role = mock(:account_role, rights)
    user.stub(:role_for).with(account).and_return(account_role)
    user.stub(:extend).and_return user
  end

end
