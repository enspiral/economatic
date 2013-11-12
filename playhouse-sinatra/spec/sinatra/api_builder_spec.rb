require 'spec_helper'
require 'playhouse/sinatra/api_builder'

describe Playhouse::Sinatra::ApiBuilder do
  let(:api) {double('Play', commands: ['command_1', 'command_2'], name: 'play')}
  let(:app) {double('Sinatra App')}
  let(:command_builder) {double(Playhouse::Sinatra::CommandBuilder)}

  before(:each) do
    command_builder.stub(:build_command).and_return('method_name')
    Playhouse::Sinatra::CommandBuilder.stub(:new).and_return(command_builder)
  end

  describe 'build_sinatra_api' do
    let(:result) {Playhouse::Sinatra::ApiBuilder.build_sinatra_api(api, app)}

    it 'returns a hash with the api name as key' do
      expect(result[:play]).to_not be_nil
    end

    it 'returns an array of methods for each play' do
      expect(result[:play]).to eq(['method_name', 'method_name'])
    end

    it 'calls command_builder.build_command for each command' do
      result
      expect(command_builder).to have_received(:build_command).twice
    end
  end
end