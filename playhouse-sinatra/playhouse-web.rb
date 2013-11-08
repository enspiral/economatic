require 'sinatra/base'

class PlayhouseWeb < Sinatra::Base
  get '/' do
    'Hello World'
  end
end