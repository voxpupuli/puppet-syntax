lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet-syntax/version'

Gem::Specification.new do |spec|
  spec.name          = 'puppet-syntax'
  spec.version       = PuppetSyntax::VERSION
  spec.authors       = ['Vox Pupuli']
  spec.email         = ['voxpupuli@groups.io']
  spec.description   = 'Syntax checks for Puppet manifests and templates'
  spec.summary       = 'Syntax checks for Puppet manifests, templates, and Hiera YAML'
  spec.homepage      = 'https://github.com/voxpupuli/puppet-syntax'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency 'puppet', '>= 7', '< 9'
  spec.add_dependency 'rake', '~> 13.1'

  spec.add_development_dependency 'pry', '~> 0.14.2'
  spec.add_development_dependency 'rb-readline', '~> 0.5.5'

  spec.add_development_dependency 'voxpupuli-rubocop', '~> 2.6.0'
end
