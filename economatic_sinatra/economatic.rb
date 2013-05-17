require 'sinatra'
require 'playhouse/theatre'
require 'economatic_core'

theatre = Playhouse::Theatre.new(environment: 'development')

theatre.stage do
  play = Economatic::API.new

  play.commands.each do |command|
    puts command.method_name
    get "/#{command.method_name}" do
      command.methods.inspect
    end
  end

  get '/' do
    output = ""
    play.commands.each do |command|
      output += "<a href='/#{command.method_name}'>#{command.method_name}</a><br/>"
    end
    output
  end
end
