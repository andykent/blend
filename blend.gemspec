Gem::Specification.new do |s|
  s.name = %q{blend}
  s.version = "0.1"
  s.authors = ["Andy Kent"]
  s.date = %q{2009-06-25}
  s.email = %q{andy.kent@me.com}
  s.homepage = %q{http://github.com/andykent/blend/}
  s.files = ['lib/blend.rb', 'lib/collection.rb', 'lib/renderer.rb', 'lib/template.rb']
  s.require_paths = ["lib"]
  s.add_dependency(%q{hpricot}, [">= 0.8"])
  s.summary = %q{A CSS powered HTML injection engine.}
end
