APPS = %w(console_interface economatic_core)

desc "Setup databases, gems and other requirements for all apps"
task :setup_ci do
  APPS.each do |app|
    system %{cd #{app}; pwd; echo "bundle install"; bundle install}
  end
end

desc "Run tests for all parts of this repository"
task :ci do
  APPS.each do |app|
    sh %{cd #{app}; bundle exec rake ci}
  end
end
