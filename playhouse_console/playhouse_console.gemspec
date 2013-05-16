Gem::Specification.new do |s|
  s.name = "playhouse-console"
  s.version = '0.1.0'
  s.authors = ["Craig Ambrose", "Joshua Vial"]
  s.email = ["craig@enspiral.com", "joshua@enspiral.com"]
  s.homepage = "https://github.com/enspiral/economatic"
  s.summary = "A console delivery layer for playhouse"
  s.description = "Based on Thor"

  s.require_paths = %w(lib)

  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(spec)/})

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'thor'
  s.add_dependency 'playhouse'
end