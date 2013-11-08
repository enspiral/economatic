When /^I go to '(.)'$/ do |path|
  visit path
end

Then /^I see '(.*)'$/ do |text|
  page.should have_content text
end
