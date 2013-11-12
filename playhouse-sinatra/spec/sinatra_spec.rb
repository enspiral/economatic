require 'spec_helper'
require 'sinatra/base'
require 'playhouse/sinatra'
require 'playhouse/play'

class App < Sinatra::Base
end

class Play < Playhouse::Play
end

describe Playhouse::Sinatra do
  before(:each) do
    App.register Playhouse::Sinatra
  end
  it 'creates a plays setting' do
    expect(App.settings.plays).to eq([])
  end

  describe 'plays' do
    before(:each) do
      App.add_play

    end
  end

end