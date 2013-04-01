require_relative '../paths.rb'
require 'boot'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean_with(:truncation)

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end