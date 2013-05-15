require 'economatic_core'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean_with(:truncation)

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

def api
  @api ||= Economatic::API.new
end
