
namespace :db do
  namespace :schema do
    task :load do
      require_relative 'app/extras/paths'
      require 'boot'
      load File.join(ROOT_PATH, 'db/schema.rb')
    end
  end
end