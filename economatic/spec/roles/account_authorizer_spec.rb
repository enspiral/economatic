require 'spec_helper'
require 'economatic/roles/account_authorizer'

module Economatic
  describe AccountAuthorizer do
    include UsesDatabase

    let(:actor) {Object.new.tap {|a| a.stub(:id => 2)}}
    let(:account) {double(:account, id: 1, bank_id: 2)}
    let(:bank) {double(:bank, id: 2)}
    subject {actor.extend AccountAuthorizer}

    context "role_for" do
      it "returns a bank role if present" do
        role = BankRole.create(user_id: 2, bank_id: bank.id)
        subject.role_for_account(account).should == role
      end

      it "returns an account role if present" do
        role = AccountRole.create(user_id: 2, account_id: account.id)
        subject.role_for_account(account).should == role
      end

      it "returns account role if both account and bank roles are present" do
        BankRole.create(user_id: 2, bank_id: bank.id)
        account_role = AccountRole.create(user_id: 2, account_id: account.id)
        subject.role_for_account(account).should == account_role
      end

      it "returns a null account role no role is present" do
        result = subject.role_for_account(account).should be_a NullAccountRole
      end
    end
  end
end