require_relative 'paths'
require 'boot'
require 'active_support/core_ext/object/inclusion'

namespace :db do
  namespace :schema do
    task :load do
      load File.join(ROOT_PATH, 'db/schema.rb')
    end
  end
  task :drop do
    FileUtils.rm(File.join(ROOT_PATH, 'db/test.sqlite'))
  end
  task :reset do
    task('db:drop').invoke
    task('db:schema:load').invoke
  end
end

require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
end

require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

desc "Run cukes and specs"
task :ci => [:spec, :features] do
end
