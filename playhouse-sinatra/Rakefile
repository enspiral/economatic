require 'rspec/core/rake_task'

desc "Setup sinatra interface for CI"
task :setup_ci do
  puts "nothing to setup"
end

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
end

desc "Travis"
  task :ci => [:spec] do
end

task :default => [:ci]
