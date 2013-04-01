require 'spec_helper'
require 'talent_scout'
require 'context'

describe TalentScout do
  context "for a context with a single actor" do
    context "that is an entity" do
      subject { TalentScout.new(@context_class) }
      let(:entity) { mock(:entity) }
      let(:entity_repository) { mock(:repository) }

      before do
        @context_class = Class.new(Context)
      end

      context "with a repository specified" do
        before do
          @context_class.actor :source_account, repository: entity_repository
        end

        it "finds the entity using the supplied id" do
          entity_repository.should_receive(:find).with('2').and_return(entity)
          context = subject.build_context(source_account_id: '2')
          context.source_account.should == entity
        end

        it "finds no entity if no id is supplied" do
          context = subject.build_context(some_other_id: '2')
          context.source_account.should == nil
        end

        it "uses the entity itself if it is supplied" do
          context = subject.build_context(source_account: entity)
          context.source_account.should == entity
        end
      end

      context "without a repository specified" do
        before do
          @context_class.actor :source_account
        end

        it "does not find the entity" do
          context = subject.build_context(source_account_id: '2')
          context.source_account.should == nil
        end

        it "uses the entity itself if it is supplied" do
          context = subject.build_context(source_account: entity)
          context.source_account.should == entity
        end
      end
    end
  end
end