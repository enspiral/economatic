When /^I go to '(.)'$/ do |path|
  visit path
end

Then /^I see '(.*)'$/ do |text|
  page.should have_content text
end

Given(/^sinatra includes a play called '(.*)'$/) do |play_name|
end

