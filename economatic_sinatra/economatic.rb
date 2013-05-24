require 'sinatra/base'

class EconomaticWeb < Sinatra::Base
  get '/' do
    'Hello World'
  end
end