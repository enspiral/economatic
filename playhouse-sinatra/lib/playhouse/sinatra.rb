module Playhouse
  module Sinatra
    def add_play play
      settings.plays << play
    end
    def self.registered(app)
      app.set :plays, []
      app.get '/plays' do
        settings.plays.collect(&:name).join(',')
      end
    end
  end
end