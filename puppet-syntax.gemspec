# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet-syntax/version'

Gem::Specification.new do |spec|
  spec.name          = "puppet-syntax"
  spec.version       = PuppetSyntax::VERSION
  spec.authors       = ["Vox Pupuli"]
  spec.email         = ["voxpupuli@groups.io"]
  spec.description   = %q{Syntax checks for Puppet manifests and templates}
  spec.summary       = %q{Syntax checks for Puppet manifests, templates, and Hiera YAML}
  spec.homepage      = "https://github.com/voxpupuli/puppet-syntax"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7"

  spec.add_dependency "rake"
  spec.add_dependency "puppet", ">= 7"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rb-readline"

  spec.add_development_dependency 'rubocop', '~> 1.12.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.10'
  spec.add_development_dependency 'rubocop-rake', '~> 0.2'
  spec.add_development_dependency 'rubocop-rspec', '>= 1.44'
end
