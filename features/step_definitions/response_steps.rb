When /^(.*) an error should be raised$/ do |original_step|
  expect {
    step(original_step)
  }.to raise_error
end

When /^(.*) an error should not be raised$/ do |original_step|
  step(original_step)
end
