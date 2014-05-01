# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geese/version'

Gem::Specification.new do |spec|
  spec.name          = "geese"
  spec.version       = Geese::VERSION
  spec.authors       = ["Andy Maes", "Ariejan de Vroom"]
  spec.email         = ["andymaes@gmail.com", "ariejan@ariejan.net"]
  spec.summary       = %q{To be announced.}
  spec.description   = %q{To be announced}
  spec.homepage      = "http://blackgeese.github.io/geese"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "pry"
end
