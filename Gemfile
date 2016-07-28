source 'https://rubygems.org'

# Specify your gem's dependencies in puppet-syntax.gemspec
gemspec

# Override gemspec for CI matrix builds.
puppet_version = ENV['PUPPET_VERSION'] || '>2.7.0'
gem 'puppet', puppet_version

# older version required for ruby 1.9 compat, as it is pulled in as dependency of puppet, this has to be carried by the module
gem 'json_pure', '<= 2.0.1'
