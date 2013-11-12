task :environment do
  require 'playhouse/theatre'
  require 'economatic_core'
  theatre = Playhouse::Theatre.new(root: @root_dir, environment: 'test')
  theatre.start_staging
end

namespace :db do
  namespace :schema do
    task :load => :environment do
      load File.join(Economatic::ROOT_PATH, 'db/schema.rb')
    end
  end
  task :drop => :environment do
    FileUtils.rm_f(File.join(Economatic::ROOT_PATH, 'db/test.sqlite'))
  end

  desc "rebuild the database from schema.rb"
  task :reset => :environment do
    task('db:drop').invoke
    task('db:schema:load').invoke
  end
end