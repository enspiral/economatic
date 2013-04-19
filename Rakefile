desc "Run tests for all parts of this repository"
task :ci do
  sh %{cd console_interface; bundle exec rake ci}
  sh %{cd core_application; bundle exec rake ci}
end
