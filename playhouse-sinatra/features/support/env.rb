require File.join(File.expand_path(File.dirname(__FILE__)),'../../playhouse-web')

ENV['RACK_ENV'] = 'test'

require "capybara"
require "capybara/cucumber"
require "rspec"

Capybara.app = PlayhouseSinatra

class PlayhouseWebWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  PlayhouseWebWorld.new
end