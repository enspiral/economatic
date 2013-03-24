require 'spec_helper'
require 'transaction_source'
require 'money'

describe TransactionSource do
  class WithTransactionSource
    attr_accessor :minimum_balance
    def initialize(params)
      @minimum_balance = params[:minimum_balance]
    end
  end

  subject { actor.extend(TransactionSource) }

  describe '.will_allow_transaction?' do
    let(:transaction) { mock(:transaction) }

    context "with no minimum balance" do
      let(:actor) { WithTransactionSource.new(minimum_balance: nil) }

      it "will allow" do
        subject.will_allow_transaction?(transaction).should be_true
      end
    end

    context "with minimum balance" do
      let(:actor) { WithTransactionSource.new(minimum_balance: -100.0) }

      context "with zero existing balance" do
        before do
          subject.stub!(amount: Money.new(0.0))
        end

        it "will allow if transaction wouldn't take me below minimum balance" do
          transaction.stub(:amount, Money.new(90.0))
          subject.will_allow_transaction?(transaction).should be_true
        end

        it "wont allow if transaction would take me below minimum balance" do
          transaction.stub(:amount, Money.new(110.0))
          subject.will_allow_transaction?(transaction).should be_false
        end
      end

      context "with existing balance" do
        it "will allow if my balance would not be below my minimum balance if this transaction was performed" do
          pending
          transaction.stub(:amount, Money.new(90.0))
          subject.will_allow_transaction?(transaction).should be_true
        end

        it "wont allow if my balance would be below minimum balance if this transaction was performed" do
          pending
          transaction.stub(:amount, Money.new(110.0))
          subject.will_allow_transaction?(transaction).should be_false
        end
      end
    end
  end
end