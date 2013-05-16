require 'playhouse/console/command_builder'
require 'thor'

module Playhouse
  module Console
    class ApiBuilder
      def self.build_console_api(api, name = 'ConsoleApi')
        console_class = Class.new(Thor)

        command_builder = Playhouse::Console::CommandBuilder.new(console_class, api)

        api.commands.each do |command|
          command_builder.build_command(command)
        end

        console_class
      end
    end
  end
end