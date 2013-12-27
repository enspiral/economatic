require 'spec_helper'
require 'economatic/roles/account_entry_collection'

module Economatic
  describe AccountEntryCollection do
    let(:actor) {Object.new.tap {|a| a.stub(:id => 1)}}
    let(:non_pending) {double(:non_pending)}
    let(:entries) {double(:entries)}
    subject { actor.extend AccountEntryCollection }

    describe '#balance' do
      it 'returns sum of all non pending transactional entries for this account' do
        summable = double(:summable, sum: 2300)
        entries.stub(:where).with(pending: false).and_return(summable)
        actor.stub(:entries).and_return(entries)

        subject.balance.should == Money.new(2300)
      end
    end
  end
end