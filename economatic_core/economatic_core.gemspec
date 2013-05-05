Gem::Specification.new do |s|
  s.name = "economatic-core"
  s.version = '0.1.0'
  s.authors = ["Craig Ambrose", "Joshua Vial"]
  s.email = ["craig@enspiral.com", "joshua@enspiral.com"]
  s.homepage = "https://github.com/enspiral/economatic"
  s.summary = "A banking backend"
  s.description = "Banks with accounts and transactions"

  s.require_paths = %w(lib)

  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(spec)/})

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'activerecord'
  s.add_dependency 'sqlite3'
  s.add_dependency 'rake'
  s.add_dependency 'money'
  s.add_dependency 'playhouse'

  # These need to become development dependencies only
  s.add_dependency 'timecop'
  s.add_dependency 'cucumber'
  s.add_dependency 'rspec'
  s.add_dependency 'database_cleaner'
  s.add_dependency 'coveralls'

end