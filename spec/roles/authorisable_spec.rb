require 'spec_helper'
require 'authorisable'

describe Authorisable do
  include UsesDatabase

  let(:actor) {Object.new.tap {|a| a.stub!(:id => 2)}}
  let(:account) {mock(:account, id: 1)}
  subject {actor.extend Authorisable}

  context "role_for" do
    it "returns a role if present" do
      role = AccountRole.create(account_id: account.id, user_id: 2)
      subject.role_for(account).should == role
    end

    it "returns a null account role no role is present" do
      result = subject.role_for(account).should be_a NullAccountRole
    end
  end
end
