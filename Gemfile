source 'https://rubygems.org'

# Find a location or specific version for a gem. place_or_version can be a
# version, which is most often used. It can also be git, which is specified as
# `git://somewhere.git#branch`. You can also use a file source location, which
# is specified as `file://some/location/on/disk`.
def location_for(place_or_version, fake_version = nil)
  if place_or_version =~ /^(https[:@][^#]*)#(.*)/
    [fake_version, { git: Regexp.last_match(1), branch: Regexp.last_match(2), require: false }].compact
  elsif place_or_version =~ %r{^file://(.*)}
    ['>= 0', { path: File.expand_path(Regexp.last_match(1)), require: false }]
  else
    [place_or_version, { require: false }]
  end
end

# Specify your gem's dependencies in puppet-syntax.gemspec
gemspec

# Override gemspec for CI matrix builds.
# But only if the environment variable is set
gem 'puppet', *location_for(ENV['PUPPET_VERSION']) if ENV['PUPPET_VERSION']
# Puppet on Ruby 3.3 / 3.4 has some missing dependencies
gem 'base64', '~> 0.2' if RUBY_VERSION >= '3.4'
gem 'getoptlong', '~> 0.2' if RUBY_VERSION >= '3.4'
gem 'racc', '~> 1.8' if RUBY_VERSION >= '3.3'
gem 'syslog', '~> 0.3' if RUBY_VERSION >= '3.4'

group :test do
  gem 'rspec'
end

group :release, optional: true do
  gem 'faraday-retry', '~> 2.1', require: false
  gem 'github_changelog_generator', '~> 1.16.4', require: false
end
