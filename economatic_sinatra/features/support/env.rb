ENV['RACK_ENV'] = 'test'
require File.join(File.expand_path(File.dirname(__FILE__)),'../../economatic')



require "capybara"
require "capybara/cucumber"
require "rspec"

Capybara.app = EconomaticWeb

class EconomaticWebWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  EconomaticWebWorld.new
end