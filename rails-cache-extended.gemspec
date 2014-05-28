# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/cache/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-cache-extended'
  spec.version       = CacheExtended::VERSION
  spec.authors       = ['Thibault El Zamek, Cédric Darné, Lionel Oto']
  spec.email         = ['thibault.elzamek@c4mprod.com, cedric.darne@c4mprod.com, lionel.oto@c4mprod.com']
  spec.description   = %q{This allows to generate an auto-expiring cache key for a collection of records }
  spec.summary       = %q{This allows to generate an auto-expiring cache key for a collection of records }
  spec.homepage      = 'https://github.com/c4mprod/rails-cache-extended'
  spec.license       = 'MIT'

  spec.files = Dir[*%w( LICENSE.txt README.md lib/**/* )]
  spec.test_files = Dir['spec/**/*']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rails', '~> 3.2'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails'
end
