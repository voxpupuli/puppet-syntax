source 'https://rubygems.org'

# Specify your gem's dependencies in puppet-syntax.gemspec
gemspec

# Override gemspec for CI matrix builds.
if ENV['PUPPET_VERSION']
  gem 'puppet', ENV['PUPPET_VERSION']
end
