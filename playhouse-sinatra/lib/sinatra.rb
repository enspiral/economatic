module Playhouse
  module Sinatra
    def self.registered(app)
      app.get '/plays' do
        'economatic'
      end
    end
  end
end