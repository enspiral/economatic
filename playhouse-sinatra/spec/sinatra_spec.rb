require 'spec_helper'
require 'sinatra/base'
require 'playhouse/sinatra'
require 'playhouse/play'

class App < Sinatra::Base
end

class TestPlay < Playhouse::Play

end

describe Playhouse::Sinatra do
  before(:each) do
    stub_theatre
    App.register Playhouse::Sinatra
  end
  describe 'register' do
    subject {App.settings}
    it 'creates a plays setting' do
      expect(subject.plays).to eq([])
    end
    it 'creates an apis setting' do
      expect(subject.apis).to eq({})
    end
  end

  describe 'add_play' do
    before(:each) do
      App.add_play TestPlay
    end
    it 'creates a new theatre for each play' do
      expect(App.settings.apis.size).to eq(1)
    end
  end

end