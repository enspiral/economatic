require 'active_record'
require 'sqlite3'
require 'active_record/connection_adapters/sqlite3_adapter'
require 'economatic/economatic_play'

module Economatic
  ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))
end
