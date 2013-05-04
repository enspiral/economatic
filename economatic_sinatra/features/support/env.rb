require File.join(File.expand_path(File.dirname(__FILE__)),'../../economatic')

require "Capybara"
require "Capybara/cucumber"
require "rspec"

World do
  Capybara.app = Sinatra::Application

  include Capybara::DSL
  include RSpec::Matchers
end