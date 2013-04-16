require 'spec_helper'
require 'account_variation_collection'

describe AccountVariationCollection do
  let(:actor) {Object.new.tap {|a| a.stub!(:id => 1)}}
  #let(:non_pending) {stub(:non_pending)}
  subject { actor.extend AccountVariationCollection }

  describe '#balance' do
    it 'returns sum of all variations for this account' do
      summable = mock(:summable, :sum => 2300)
      actor.stub(:variations).and_return(summable)

      subject.balance.should == Money.new(2300)
    end
  end
end
