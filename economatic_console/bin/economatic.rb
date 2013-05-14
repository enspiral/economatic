#!/usr/bin/env ruby

require 'thor'
require 'economatic_core'
require 'playhouse/console/command_builder'

class EconomaticConsole < Thor
end

api = Economatic::API.new

command_builder = Playhouse::Console::CommandBuilder.new(EconomaticConsole)

api.commands.each do |command|
  command_builder.build_command(command)
end

EconomaticConsole.start(ARGV)