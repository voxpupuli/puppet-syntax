[![Build Status](https://travis-ci.org/voxpupuli/puppet-syntax.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet-syntax)

# Puppet::Syntax

Puppet::Syntax checks for correct syntax in Puppet manifests, templates, and Hiera YAML.

## Version support

Puppet::Syntax is supported with:

- Puppet >= 2.7 that provides the `validate` face.
- Ruby >= 1.8 with `erb` from Ruby stdlib.

For the specific versions that we test against, see the [TravisCI config](.travis.yml).

If you're using `puppetlabs_spec_helper/rake_tasks` and getting unexpected non-zero exit codes, upgrade to [puppetlabs_spec_helper][psh] version 0.8.0 or greater. Versions of `puppetlabs_spec_helper` prior to 0.8.0 conflicted with Puppet::Syntax.

[psh]: https://github.com/puppetlabs/puppetlabs_spec_helper

## Installation

To install Puppet::Syntax, either add it to your module's Gemfile or install the gem manually.

* To install with the Gemfile, add:

        gem 'puppet-syntax'

  And then execute:

        $ bundle install

* To install the gem yourself, run:

        $ gem install puppet-syntax

## Configuration

To configure Puppet::Syntax, add any of the following settings to your `Rakefile`.

* To exclude certain paths from the syntax checks, set:

        PuppetSyntax.exclude_paths = ["vendor/**/*"]

* To use the Puppet 4 ("future") parser in Puppet 3.2 through 3.8, set:

        PuppetSyntax.future_parser = true

* To configure specific paths for the Hiera syntax check, specify `hieradata_paths`. This is useful if you use Hiera data inside your module.

        PuppetSyntax.hieradata_paths = ["**/data/**/*.yaml", "hieradata/**/*.yaml", "hiera*.yaml"]

* To validate the syntax of code written for application orchestration, enable `app_management`:

        PuppetSyntax.app_management = true

  The `app_management` setting is supported with Puppet 4.3 or greater and is off by default. In Puppet 5, app_management is always enabled.

* To ignore deprecation warnings, disable `fail_on_deprecation_notices`. By default, `puppet-syntax` fails if it encounters Puppet deprecation notices. If you are working with a legacy code base and want to ignore such non-fatal warnings, you might want to override the default behavior.

        PuppetSyntax.fail_on_deprecation_notices = false

* To enable a syntax check on Hiera keys, set:

        PuppetSyntax.check_hiera_keys = true

   This reports common mistakes in key names in Hiera files, such as:

  - Leading `::` in keys, such as: `::notsotypical::warning2: true`.
  - Single colon scope separators, such as: `:picky::warning5: true`.
  - Invalid camel casing, such as: `noCamelCase::warning3: true`.
  - Use of hyphens, such as: `no-hyphens::warning4: true`.

## Usage

* To enable Puppet::Syntax, include the following in your module's `Rakefile`:

        require 'puppet-syntax/tasks/puppet-syntax'

  For Continuous Integration, use Puppet::Syntax in conjunction with `puppet-lint` and spec tests. Add the following to your module's `Rakefile`:

        task :test => [
          :syntax,
          :lint,
          :spec,
        ]

* To test all manifests and templates, relative to the location of the `Rakefile`, run:

        $ bundle exec rake syntax
        ---> syntax:manifests
        ---> syntax:templates
        ---> syntax:hiera:yaml

* To return a non-zero exit code and an error message on any failures, run:

        $ bundle exec rake syntax
        ---> syntax:manifests
        rake aborted!
        Could not parse for environment production: Syntax error at end of file at demo.pp:2
        Tasks: TOP => syntax => syntax:manifests
        (See full trace by running task with --trace)

## Checks

Puppet::Syntax makes the following checks in the directories and subdirectories of the module, relative to the location of the `Rakefile`.

### Hiera

Checks `.yaml` files for syntax errors.

By default, this rake task looks for all `.yaml` files in a single module under:

* `**/data/**/*.yaml`
* `hieradata/**/*.yaml`
* `hiera*.yaml`

### manifests

Checks all `.pp` files in the module for syntax errors.

### templates

#### erb

Checks `.erb` files in the module for syntax errors.

#### epp

Checks `.epp` files in the module for syntax errors.

EPP checks are supported in Puppet 4 or greater, or in Puppet 3 with the future parser enabled.

## Contributing

1. Fork the repo.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.
