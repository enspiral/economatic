module Playhouse
  module Console
    class CommandBuilder
      def initialize(console_api)
        @console_api = console_api
      end

      def build_command(command)
        @console_api.desc command.method_name, ''

        command.parts.each do |part|
          @console_api.method_option part.name, required: part.required
        end

        @console_api.send :define_method, command.method_name do
          api.send(command.method_name, options)
        end
      end
    end
  end
end