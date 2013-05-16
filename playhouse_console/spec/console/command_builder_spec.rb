require 'spec_helper'
require 'playhouse/console/command_builder'
require 'ostruct'

describe Playhouse::Console::CommandBuilder do
  let(:api) { MockApi.new }
  let(:play) { mock(:play) }
  let(:repos) { mock(:repository) }
  subject { Playhouse::Console::CommandBuilder.new(api, play) }

  class MockApi < OpenStruct
    def desc(name, description)
      self.name = name
      self.description = description
    end

    def method_option(name, options)
      @method_options ||= {}
      @method_options[name] = options
    end

    def define_method(name)
      self.added_methods = {}
      self.added_methods[name] = @method_options
      @method_options = {}
    end
  end

  describe "#build_command" do
    def mock_context(options = {})
      defaults = {method_name: 'destroy_planet', parts: []}
      mock(:context, defaults.merge(options))
    end

    def mock_part(options = {})
      defaults = {name: 'star_name', required: false, repository: nil}
      mock(:part, defaults.merge(options))
    end

    it "sets the method name from the context" do
      subject.build_command(mock_context)
      api.name.should == 'destroy_planet'
    end

    it "adds a string option for a regular part" do
      subject.build_command(mock_context(parts: [mock_part]))
      api.added_methods['destroy_planet'].should have_key('star_name')
    end

    it "marks option as required if part is required" do
      subject.build_command(mock_context(parts: [mock_part(required: true)]))
      api.added_methods['destroy_planet']['star_name'][:required].should be_true
    end

    it "adds 'id' suffix to option with a repository" do
      subject.build_command(mock_context(parts: [mock_part(repository: repos)]))
      api.added_methods['destroy_planet'].keys.should == ['star_name_id']
    end
  end
end
