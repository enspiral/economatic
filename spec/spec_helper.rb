if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require_relative '../paths.rb'
require 'boot'
require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
end

module UsesDatabase
  def self.included(base)
    base.before(:each) do
      DatabaseCleaner.start
    end
    base.after(:each) do
      DatabaseCleaner.clean
    end
  end
end