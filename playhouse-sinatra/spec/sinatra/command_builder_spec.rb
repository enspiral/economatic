require 'spec_helper'
require 'playhouse/sinatra/command_builder'

describe Playhouse::Sinatra::CommandBuilder do
  let(:app) {double('Sinatra App')}
  let(:subject) {Playhouse::Sinatra::CommandBuilder.new(app)}

  describe 'build_command' do
    let(:command) {double('Context', method_name: 'context_name')}
    let(:result) {subject.build_command(command)}
    it 'returns the method name of the passed command' do
      expect(result).to eq('context_name')
    end
  end

end