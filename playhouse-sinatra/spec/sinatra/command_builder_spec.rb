require 'spec_helper'
require 'playhouse/sinatra/command_builder'

describe Playhouse::Sinatra::CommandBuilder do
  let(:app) {double('Sinatra App', get: nil, post: nil)}
  let(:api) {double('Play', name: 'play_name')}
  let(:subject) {Playhouse::Sinatra::CommandBuilder.new(api, app)}

  describe 'build_command' do
    let(:command) {double('Context', method_name: 'context_name')}
    let(:result) {subject.build_command(command)}
    it 'returns the method name of the passed command' do
      expect(result).to eq('context_name')
    end
    it 'creates a get method for each command' do
      expect(app).to receive(:get).with('/play_name/context_name')
      result
    end
    it 'creates a post method for each command' do
      expect(app).to receive(:post).with('/play_name/context_name')
      result
    end
  end

end