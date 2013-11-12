require 'playhouse/play'

When /^I go to '(.*)'$/ do |path|
  visit path
end

Then /^I see '(.*)'$/ do |text|
  page.should have_content text
end

Given(/^sinatra includes a play called '(.*)'$/) do |play_name|
  eval  "class #{play_name.capitalize} < Playhouse::Play; end"
  play = eval("#{play_name.capitalize}.new")
  Capybara.app.add_play(play)
end


