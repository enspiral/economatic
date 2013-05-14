APPS = %w(playhouse economatic economatic_console) # economatic_sinatra

desc "Setup databases, gems and other requirements for all apps"
task :setup_ci do
  APPS.each do |app|
    system %{cd #{app}; pwd; bundle exec rake setup_ci}
  end
end

desc "Run tests for all parts of this repository"
task :ci => :setup_ci do
  APPS.each do |app|
    sh %{cd #{app}; bundle exec rake ci}
  end
end
