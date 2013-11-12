require 'spec_helper'
require 'playhouse/sinatra/command_builder'

describe Playhouse::Sinatra::CommandBuilder do
  let(:app) {double('Sinatra App', get: nil, post: nil)}
  let(:api) {double('Play', name: 'play_name')}
  let(:subject) {Playhouse::Sinatra::CommandBuilder.new(api, app)}

  describe 'build_command' do
    let(:part1) {double('Part', name: 'part_1', required: false, repository: false)}
    let(:part2) {double('Part', name: 'part_2', required: true, repository: false)}
    let(:part3) {double('Part', name: 'part_3', required: false, repository: true)}
    let(:command) {double('Context', method_name: 'context_name', parts: [part1, part2, part3])}

    let(:result) {subject.build_command(command)}

    it 'returns the method name and parts for the command' do
      expect(result['/play_name/context_name']).to eq(['part_1', 'part_2', 'part_3_id'])
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