require 'active_record'
require 'sqlite3'
require 'active_record/connection_adapters/sqlite3_adapter'

db_params = YAML.load(File.read(ROOT_PATH + "/config/database.yml"))['test']
ActiveRecord::Base.establish_connection db_params
