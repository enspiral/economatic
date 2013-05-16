#!/usr/bin/env ruby
require 'playhouse/theatre'
require 'economatic_core'
require 'playhouse/console/api_builder'

root_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))

theatre = Playhouse::Theatre.new(root: root_dir, environment: 'development')
theatre.stage do
  play = Economatic::API.new

  EconomaticConsole = Playhouse::Console::ApiBuilder.build_console_api(play)
  EconomaticConsole.start(ARGV)
end
