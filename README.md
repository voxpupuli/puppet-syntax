# Puppet::Syntax

Syntax checks for Puppet manifests and templates

## Usage

Include the following in your `Rakefile`:

    require 'puppet-syntax/tasks/puppet-syntax'

Paths can be excluded with:

    PuppetSyntax.exclude_paths = ["vendor/**/*"]

## Installation

Add this line to your application's Gemfile:

    gem 'puppet-syntax'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puppet-syntax

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
