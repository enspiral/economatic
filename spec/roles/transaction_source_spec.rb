require 'spec_helper'
require 'transaction_source'
require 'money'

describe TransactionSource do
  class WithTransactionSource
    attr_accessor :minimum_balance, :bank
    def initialize(params)
      @minimum_balance = params[:minimum_balance]
      @bank = params[:bank]
    end
  end

  let(:bank) {mock(:bank)}
  let(:actor) { WithTransactionSource.new(minimum_balance: nil, bank: bank) }
  subject { actor.extend(TransactionSource) }

  describe '.will_allow_transaction?' do
    let(:transaction) { mock(:transaction) }

    context "between accounts in the same bank" do
      before do
        transaction.stub_chain(:source_account,:bank).and_return(bank)
        transaction.stub_chain(:destination_account,:bank).and_return(bank)
      end

      context "with no minimum balance" do
        it "will allow" do
          subject.will_allow_transaction?(transaction).should be_true
        end
      end

      context "with minimum balance" do
        let(:actor) { WithTransactionSource.new(minimum_balance: Money.new(-100.0), bank: bank) }

        context "with zero existing balance" do
          before do
            subject.stub!(balance: Money.new(0.0))
          end

          it "will allow if transaction wouldn't take me below minimum balance" do
            transaction.stub(amount: Money.new(90.0))
            subject.will_allow_transaction?(transaction).should be_true
          end

          it "wont allow if transaction would take me below minimum balance" do
            transaction.stub(amount: Money.new(110.0))
            subject.will_allow_transaction?(transaction).should be_false
          end
        end

        context "with existing balance" do
          before do
            subject.stub!(balance: Money.new(10.0))
          end

          it "will allow if my balance would not be below my minimum balance if this transaction was performed" do
            transaction.stub(amount: Money.new(105.0))
            subject.will_allow_transaction?(transaction).should be_true
          end

          it "wont allow if my balance would be below minimum balance if this transaction was performed" do
            transaction.stub(amount: Money.new(115.0))
            subject.will_allow_transaction?(transaction).should be_false
          end
        end
      end
    end
    context "between accounts in different banks" do
      let(:other_bank) {mock(:other_bank)}

      it "returns false" do
        transaction.stub_chain(:source_account,:bank).and_return(bank)
        transaction.stub_chain(:destination_account,:bank).and_return(other_bank)
        subject.will_allow_transaction?(transaction).should be_false
      end
    end
  end
end