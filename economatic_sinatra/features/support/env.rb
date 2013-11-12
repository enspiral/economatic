ENV['RACK_ENV'] = 'test'
require File.join(File.expand_path(File.dirname(__FILE__)),'../../economatic')

features_dir = File.join(File.expand_path(File.dirname(__FILE__)),'../../../economatic/features/step_definitions')

require "#{features_dir}/account_steps"
require "#{features_dir}/bank_steps"
require "#{features_dir}/user_steps"

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