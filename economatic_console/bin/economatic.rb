#!/usr/bin/env ruby
require 'playhouse/theatre'
require 'economatic_core'
require 'playhouse/console/interface'

root_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))

theatre = Playhouse::Theatre.new(root: root_dir, environment: 'development')
theatre.stage do
  play = Economatic::EconomaticPlay.new

  EconomaticConsole = Playhouse::Console::Interface.build_console_api(play)
  EconomaticConsole.start(ARGV)
end
