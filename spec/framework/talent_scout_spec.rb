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
        @context_class.actor :source_account, repository: entity_repository
      end

      it "finds the entity using the supplied id" do
        # Based on the context class, we need to be able to figure out
        # what sort of entity is actually used as a source account.
        # It's not possible to infer this from the name, we want people
        # to have the freedom to name each actor something that makes sense
        # for the context, rather than based on the type used for it.

        # Once we know what sort of entity we want (say an Account entity),
        # then we need to figure out how to find it from an id. If we're
        # using active record directly, then we could just call Account.find,
        # but it seems more appropriate that we use a repository pattern to
        # find the entity.

        pending

        entity_repository.should_receive(:find).with('2').and_return(entity)
        context = subject.build_context(source_account_id: '2')
        context.source_account.should == entity
      end
    end
  end
end