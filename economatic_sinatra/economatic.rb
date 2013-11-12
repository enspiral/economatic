require 'sinatra/base'
require 'playhouse/sinatra'
require 'economatic/api'

class EconomaticWeb < Sinatra::Base
  register Playhouse::Sinatra
  add_play Economatic::API
end