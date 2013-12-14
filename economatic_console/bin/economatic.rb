#!/usr/bin/env ruby
require 'playhouse/theatre'
require 'economatic_core'
require 'playhouse/console/interface'
require 'economatic/production'

root_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))

production = Economatic::Production.new
theatre = Playhouse::Theatre.new environment: 'development', root: root_dir

production.run theatre: theatre, interface: Playhouse::Console::Interface, interface_args: ARGV
