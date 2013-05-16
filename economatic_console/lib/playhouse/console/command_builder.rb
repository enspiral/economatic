module Playhouse
  module Console
    class CommandBuilder
      def initialize(console_api, playhouse_api)
        @console_api = console_api
        @playhouse_api = playhouse_api
      end

      def build_command(command)
        @console_api.desc command.method_name, ''

        command.parts.each do |part|
          build_command_option(part)
        end

        defined_command_handler(command)
      end

      private

        def build_command_option(part)
          @console_api.method_option option_name(part), required: part.required
        end

        def option_name(part)
          part.repository ? "#{part.name}_id" : part.name
        end

        def defined_command_handler(command)
          play = @playhouse_api
          @console_api.send :define_method, command.method_name do
            result = play.send(command.method_name, options)
            puts result.inspect
          end
        end
    end
  end
end