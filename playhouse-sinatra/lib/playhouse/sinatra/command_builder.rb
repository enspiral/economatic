module Playhouse
  module Sinatra
    class CommandBuilder
      def initialize api, sinatra_app
        @api = api
        @app = sinatra_app
      end
      def build_command(command)
        name = @api.name
        @app.get "/#{name}/#{command.method_name}" do
          settings.apis[name].send(command.method_name.to_sym, params).to_json
        end
        @app.post "/#{@api.name}/#{command.method_name}" do
          settings.apis[name].send(command.method_name.to_sym, params).to_json
        end
        command.method_name
      end
    end
  end
end