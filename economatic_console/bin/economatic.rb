#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'economatic_core'

program :version, '0.0.1'
program :description, 'A banking system'

api = Economatic::API.new

api.commands.each do |api_command|
  command api_command.method_name do |c|
    c.syntax = 'Economatic foo [options]'
    c.summary = ''
    c.description = ''
    c.example 'description', 'command example'
    c.option '--some-switch', 'Some switch that does something'
    c.action do |args, options|
      options_hash = options
      options_hash.delete(:trace)
      # Do something or c.when_called Economatic::Commands::Foo
      api.send(api_command.method_name, options_hash)
    end
  end
end
