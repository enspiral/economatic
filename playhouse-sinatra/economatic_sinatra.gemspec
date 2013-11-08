Gem::Specification.new do |s|
  s.name = "playhouse-sinatra"
  s.version = '0.1.0'
  s.authors = ["Craig Ambrose", "Joshua Vial"]
  s.email = ["craig@enspiral.com", "joshua@enspiral.com"]
  s.homepage = "https://github.com/enspiral/playhouse-sinatra"
  s.summary = "A sinatra interface to playhouse"
  s.description = "For more details, see playhouse"

  s.require_paths = %w(lib)

  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(spec)/})

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'sinatra'
  s.add_dependency 'thin'

  #dev
  s.add_dependency 'cucumber'
  s.add_dependency 'capybara'
  s.add_dependency 'rspec'
end