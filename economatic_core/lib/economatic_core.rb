require 'active_record'
require 'sqlite3'
require 'active_record/connection_adapters/sqlite3_adapter'
require 'economatic/api'

module Economatic
  ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  def self.init
    db_params = YAML.load(File.read(Economatic::ROOT_PATH + "/config/database.yml"))['test']
    ActiveRecord::Base.establish_connection db_params
  end
end

Economatic.init
