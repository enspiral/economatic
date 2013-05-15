#!/usr/bin/env ruby

require 'economatic_core'
require 'playhouse/console/api_builder'

api = Economatic::API.new

EconomaticConsole = Playhouse::Console::ApiBuilder.build_console_api(api)
EconomaticConsole.start(ARGV)