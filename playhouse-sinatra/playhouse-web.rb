require 'sinatra/base'
require 'playhouse/sinatra'

class PlayhouseSinatra < Sinatra::Base
  register Playhouse::Sinatra
end