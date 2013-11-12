require 'sinatra/base'
require 'playhouse/sinatra'
require 'economatic/api'

class EconomaticWeb < Sinatra::Base
  register Playhouse::Sinatra
  set :root,  File.expand_path(File.join(File.dirname(__FILE__)))

  add_play Economatic::API

  run! if app_file == $0
end