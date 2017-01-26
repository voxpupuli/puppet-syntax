[![Build Status](https://travis-ci.org/voxpupuli/puppet-syntax.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet-syntax)

# Puppet::Syntax

Syntax checks for Puppet manifests, templates, and Hiera YAML.

## Version support

This should work on any version of:

- Puppet >= 2.7 that provides the `validate` face.
- Ruby >= 1.8 with `erb` from stdlib.

You can see the matrix of specific versions that we currently test against
in the [TravisCI config](.travis.yml).

If you're using `puppetlabs_spec_helper/rake_tasks` and getting unexpected
non-zero exit codes then you should upgrade to [puppetlabs_spec_helper][psh]
\>= 0.8.0 which no longer has a conflicting rake task and now depends on
this project.

[psh]: https://github.com/puppetlabs/puppetlabs_spec_helper

## Usage

Include the following in your `Rakefile`:

    require 'puppet-syntax/tasks/puppet-syntax'

Test all manifests and templates relative to your `Rakefile`:

    ➜  puppet git:(master) bundle exec rake syntax
    ---> syntax:manifests
    ---> syntax:templates
    ---> syntax:hiera:yaml

A non-zero exit code and error message will be returned for any failures:

    ➜  puppet git:(master) bundle exec rake syntax
    ---> syntax:manifests
    rake aborted!
    Could not parse for environment production: Syntax error at end of file at demo.pp:2
    Tasks: TOP => syntax => syntax:manifests
    (See full trace by running task with --trace)

Use in conjunction with lint and spec tests for Continuous Integration:

    task :test => [
      :syntax,
      :lint,
      :spec,
    ]

## Checks

### hiera

Checks `.yaml` files for syntax errors.

By default, the rake task will look for all `.yaml` files under:

* `**/data/**/*.yaml`
* `hieradata/**/*.yaml`
* `hiera*.yaml`

### manifests

Checks `.pp` files for syntax errors

### templates

#### erb

Checks `.erb` files for syntax errors

#### epp

Checks `.epp` files for syntax errors.

Note: This will only occur when Puppet version specified is Puppet 4+ or Puppet 3 with the future parser enabled

## Configuration

Paths can be excluded with:

    PuppetSyntax.exclude_paths = ["vendor/**/*"]

When you are using a Puppet version greater then 3.2, you can select the future parse by specifying

    PuppetSyntax.future_parser = true

If you are using some form of hiera data inside your module, you can configure where the `syntax:hiera:yaml` task looks for data with:

    PuppetSyntax.hieradata_paths = ["**/data/**/*.yaml", "hieradata/**/*.yaml", "hiera*.yaml"]

If you are trying to validate the syntax of code written for application orchestration, you can enable the `app_management` setting:

    PuppetSyntax.app_management = true

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
