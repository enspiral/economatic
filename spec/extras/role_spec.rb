require 'spec_helper'
require 'role'

describe Role do
  module ExampleRole
    include Role

    actor_dependency :dingbat

    def foobar
      'awesome!'
    end
  end

  class DingbatActor
    def dingbat
    end
  end

  subject { ExampleRole }
  let(:valid_actor) { DingbatActor.new }
  let(:invalid_actor) { Object.new }

  context "when casting as" do
    it "adds foobar method to actor" do
      player = subject.cast_actor(valid_actor)
      player.foobar.should == 'awesome!'
    end

    it "raises exception if an actor dependency is not met" do
      expect {
        subject.cast_actor(invalid_actor)
      }.to raise_error
    end
  end

end