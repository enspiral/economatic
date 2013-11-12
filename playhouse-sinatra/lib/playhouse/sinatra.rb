require 'playhouse/theatre'
require 'playhouse/sinatra/api_builder'

module Playhouse
  module Sinatra
    def add_play play
      theatre = Playhouse::Theatre.new(root: settings.root, environment: settings.environment)
      theatre.stage do
        api = play.new
        settings.apis[api.name] = api
        settings.plays << Playhouse::Sinatra::ApiBuilder.build_sinatra_api(api, self)
      end
    end
    def self.registered(app)
      app.set :plays, []
      app.set :apis, {}

      app.get '/' do
        settings.plays.to_json
      end
    end
  end
end