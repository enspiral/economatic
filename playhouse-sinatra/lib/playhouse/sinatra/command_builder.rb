module Playhouse
  module Sinatra
    class CommandBuilder
      def initialize sinatra_app
        @app = sinatra_app
      end
      def build_command(command)
        command.method_name
      end
    end
  end
end