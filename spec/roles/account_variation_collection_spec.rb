require 'spec_helper'
require 'account_variation_collection'

describe AccountVariationCollection do
  let(:actor) {Object.new.tap {|a| a.stub!(:id => 1)}}
  let(:non_pending) {stub(:non_pending)}
  let(:variations) {stub(:variations)}
  subject { actor.extend AccountVariationCollection }

  describe '#balance' do
    it 'returns sum of all non pending variations for this account' do
      summable = mock(:summable, sum: 2300)
      variations.stub(:where).with(pending: false).and_return(summable)
      actor.stub(:variations).and_return(variations)

      subject.balance.should == Money.new(2300)
    end
  end
end
