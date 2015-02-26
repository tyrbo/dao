# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dao/version'

Gem::Specification.new do |spec|
  spec.name          = "dao"
  spec.version       = Dao::VERSION
  spec.authors       = ["Jonmichael Chambers"]
  spec.email         = ["jonmichael.chambers@livingsocial.com"]
  spec.summary       = %q{Dao is a project meant to watch for web applications running in Docker containers, which are made available on .dev domain names, similar to how pow functions for Rails applications.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_dependency "rubydns", "~> 1.0"
  spec.add_dependency "docker-api", "~> 1.17"
  spec.add_dependency "rack", "~> 1.6"
end
