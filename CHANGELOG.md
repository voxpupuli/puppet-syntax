# Changelog

All notable changes to this project will be documented in this file.

## [v7.0.1](https://github.com/voxpupuli/puppet-syntax/tree/v7.0.1) (2025-08-14)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v7.0.0...v7.0.1)

**Fixed bugs:**

- Update Hiera key regex to Puppet supported values [\#197](https://github.com/voxpupuli/puppet-syntax/pull/197) ([rridge532](https://github.com/rridge532))

## [v7.0.0](https://github.com/voxpupuli/puppet-syntax/tree/v7.0.0) (2025-08-13)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v6.0.0...v7.0.0)

**Breaking changes:**

- Require Ruby 3.2 / OpenVox 8 [\#195](https://github.com/voxpupuli/puppet-syntax/pull/195) ([bastelfreak](https://github.com/bastelfreak))
- Require Ruby \>= 3.1 [\#186](https://github.com/voxpupuli/puppet-syntax/pull/186) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- CI: Use Vox Pupuli release defaults [\#194](https://github.com/voxpupuli/puppet-syntax/pull/194) ([bastelfreak](https://github.com/bastelfreak))

## [v6.0.0](https://github.com/voxpupuli/puppet-syntax/tree/v6.0.0) (2025-06-10)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v5.0.0...v6.0.0)

**Breaking changes:**

- Switch from puppet to openvox [\#189](https://github.com/voxpupuli/puppet-syntax/pull/189) ([bastelfreak](https://github.com/bastelfreak))

## [v5.0.0](https://github.com/voxpupuli/puppet-syntax/tree/v5.0.0) (2025-05-23)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v4.1.1...v5.0.0)

**Breaking changes:**

- Set default exclude paths [\#181](https://github.com/voxpupuli/puppet-syntax/pull/181) ([bastelfreak](https://github.com/bastelfreak))
- Enable Hiera syntax check [\#167](https://github.com/voxpupuli/puppet-syntax/pull/167) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Detect Hiera files that are not valid hashes [\#184](https://github.com/voxpupuli/puppet-syntax/pull/184) ([bastelfreak](https://github.com/bastelfreak))
- CI: Switch to voxpupuli/ruby-version@v1 & Add Ruby 3.4 support [\#180](https://github.com/voxpupuli/puppet-syntax/pull/180) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- Drop unused pry & rb-readline dev dependencies [\#182](https://github.com/voxpupuli/puppet-syntax/pull/182) ([bastelfreak](https://github.com/bastelfreak))
- Cleanup Rakefile; remove legacy tasks [\#173](https://github.com/voxpupuli/puppet-syntax/pull/173) ([bastelfreak](https://github.com/bastelfreak))

## [v4.1.1](https://github.com/voxpupuli/puppet-syntax/tree/v4.1.1) (2024-04-04)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v4.1.0...v4.1.1)

**Fixed bugs:**

- fix too greedy regular expression [\#171](https://github.com/voxpupuli/puppet-syntax/pull/171) ([sprd-tmu](https://github.com/sprd-tmu))

## [v4.1.0](https://github.com/voxpupuli/puppet-syntax/tree/v4.1.0) (2024-03-12)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v4.0.1...v4.1.0)

**Implemented enhancements:**

- Hiera: Test for wrong interpolation syntax [\#143](https://github.com/voxpupuli/puppet-syntax/pull/143) ([bastelfreak](https://github.com/bastelfreak))

## [v4.0.1](https://github.com/voxpupuli/puppet-syntax/tree/v4.0.1) (2024-03-12)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v4.0.0...v4.0.1)

**Fixed bugs:**

- Raise warning if hiera check is called but disabled [\#165](https://github.com/voxpupuli/puppet-syntax/pull/165) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- Drop Puppet 5.4 check [\#166](https://github.com/voxpupuli/puppet-syntax/pull/166) ([bastelfreak](https://github.com/bastelfreak))
- README.md: Update required Puppet/Ruby versions [\#164](https://github.com/voxpupuli/puppet-syntax/pull/164) ([bastelfreak](https://github.com/bastelfreak))
- Update voxpupuli-rubocop requirement from ~\> 2.4.0 to ~\> 2.5.0 [\#163](https://github.com/voxpupuli/puppet-syntax/pull/163) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v4.0.0](https://github.com/voxpupuli/puppet-syntax/tree/v4.0.0) (2024-02-07)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v3.3.0...v4.0.0)

**Breaking changes:**

- Drop Ruby 2.4/2.5/2.6 & Puppet 5/6 support [\#145](https://github.com/voxpupuli/puppet-syntax/pull/145) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add Ruby 3.2 / Puppet 8 support [\#147](https://github.com/voxpupuli/puppet-syntax/pull/147) ([bastelfreak](https://github.com/bastelfreak))
- support aliases in hiera yaml [\#144](https://github.com/voxpupuli/puppet-syntax/pull/144) ([akerl](https://github.com/akerl))
- Implement RuboCop [\#137](https://github.com/voxpupuli/puppet-syntax/pull/137) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- fix "NameError: uninitialized constant Puppet::Util"  [\#155](https://github.com/voxpupuli/puppet-syntax/pull/155) ([mxey](https://github.com/mxey))
- add all known hiera-eyaml methods [\#154](https://github.com/voxpupuli/puppet-syntax/pull/154) ([mxey](https://github.com/mxey))

**Merged pull requests:**

- README.md: Fix badges [\#161](https://github.com/voxpupuli/puppet-syntax/pull/161) ([bastelfreak](https://github.com/bastelfreak))
- gemspec: Add version requirements & CI: Build Gems ins strict & verbose mode [\#160](https://github.com/voxpupuli/puppet-syntax/pull/160) ([bastelfreak](https://github.com/bastelfreak))
- Update voxpupuli-rubocop requirement from ~\> 2.0.0 to ~\> 2.4.0 [\#159](https://github.com/voxpupuli/puppet-syntax/pull/159) ([dependabot[bot]](https://github.com/apps/dependabot))
- Update voxpupuli-rubocop requirement from ~\> 1.4.0 to ~\> 2.0.0 [\#152](https://github.com/voxpupuli/puppet-syntax/pull/152) ([dependabot[bot]](https://github.com/apps/dependabot))
- GCG: Add faraday-retry dep [\#149](https://github.com/voxpupuli/puppet-syntax/pull/149) ([bastelfreak](https://github.com/bastelfreak))
- Switch to voxpupuli-rubocop [\#148](https://github.com/voxpupuli/puppet-syntax/pull/148) ([bastelfreak](https://github.com/bastelfreak))
- CI: add dummy job to depend on [\#146](https://github.com/voxpupuli/puppet-syntax/pull/146) ([bastelfreak](https://github.com/bastelfreak))
- Drop Ruby 1.8 testcode [\#142](https://github.com/voxpupuli/puppet-syntax/pull/142) ([bastelfreak](https://github.com/bastelfreak))
- rubocop: fix whitespace and newline warnings [\#141](https://github.com/voxpupuli/puppet-syntax/pull/141) ([bastelfreak](https://github.com/bastelfreak))
- rubocop: fix trailing comma [\#140](https://github.com/voxpupuli/puppet-syntax/pull/140) ([bastelfreak](https://github.com/bastelfreak))

## [v3.3.0](https://github.com/voxpupuli/puppet-syntax/tree/v3.3.0) (2023-02-08)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v3.2.1...v3.3.0)

**Implemented enhancements:**

- Lazy load required classes [\#134](https://github.com/voxpupuli/puppet-syntax/pull/134) ([ekohl](https://github.com/ekohl))

**Merged pull requests:**

- Pull in Puppet 6.29 in CI [\#135](https://github.com/voxpupuli/puppet-syntax/pull/135) ([ekohl](https://github.com/ekohl))

## [v3.2.1](https://github.com/voxpupuli/puppet-syntax/tree/v3.2.1) (2022-05-16)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v3.2.0...v3.2.1)

## [v3.2.0](https://github.com/voxpupuli/puppet-syntax/tree/v3.2.0) (2022-05-16)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v3.1.0...v3.2.0)

**Implemented enhancements:**

- Remove AppVeyor testing [\#94](https://github.com/voxpupuli/puppet-syntax/issues/94)
- Convert from Travis CI to GitHub Actions [\#130](https://github.com/voxpupuli/puppet-syntax/pull/130) ([ekohl](https://github.com/ekohl))

**Fixed bugs:**

- Add missing `$` in github action [\#132](https://github.com/voxpupuli/puppet-syntax/pull/132) ([bastelfreak](https://github.com/bastelfreak))

## [v3.1.0](https://github.com/voxpupuli/puppet-syntax/tree/v3.1.0) (2020-06-24)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v3.0.1...v3.1.0)

**Implemented enhancements:**

- print actual template errors on $stderr [\#125](https://github.com/voxpupuli/puppet-syntax/pull/125) ([foxxx0](https://github.com/foxxx0))

**Merged pull requests:**

- Add ruby2.7 testing, replacing multiple obsolete puppet6 versions [\#124](https://github.com/voxpupuli/puppet-syntax/pull/124) ([DavidS](https://github.com/DavidS))

## [v3.0.1](https://github.com/voxpupuli/puppet-syntax/tree/v3.0.1) (2020-05-27)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v3.0.0...v3.0.1)

**Merged pull requests:**

- Avoid failure on schedule metaparameter warning [\#122](https://github.com/voxpupuli/puppet-syntax/pull/122) ([ffapitalle](https://github.com/ffapitalle))

## [v3.0.0](https://github.com/voxpupuli/puppet-syntax/tree/v3.0.0) (2020-05-09)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.6.1...v3.0.0)

**Breaking changes:**

- Drop legacy code to support Puppet \< 5 and Ruby \< 2.4 [\#120](https://github.com/voxpupuli/puppet-syntax/pull/120) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Migrate Changelog to GCG [\#93](https://github.com/voxpupuli/puppet-syntax/issues/93)

**Merged pull requests:**

- cleanup README.md / fix markdown linter warnings [\#119](https://github.com/voxpupuli/puppet-syntax/pull/119) ([bastelfreak](https://github.com/bastelfreak))

## [v2.6.1](https://github.com/voxpupuli/puppet-syntax/tree/v2.6.1) (2020-01-11)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.6.0...v2.6.1)

**Fixed bugs:**

- Add `puppet` gem as runtime dependency [\#116](https://github.com/voxpupuli/puppet-syntax/pull/116) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- traivs: run tests on Ubuntu 18.04 [\#117](https://github.com/voxpupuli/puppet-syntax/pull/117) ([bastelfreak](https://github.com/bastelfreak))
- travis: enable irc / disable email notifications [\#114](https://github.com/voxpupuli/puppet-syntax/pull/114) ([bastelfreak](https://github.com/bastelfreak))

## [v2.6.0](https://github.com/voxpupuli/puppet-syntax/tree/v2.6.0) (2019-10-05)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.5.0...v2.6.0)

**Implemented enhancements:**

- add support for validating puppet plans \(fixes \#95, fixes \#96\) [\#97](https://github.com/voxpupuli/puppet-syntax/pull/97) ([slauger](https://github.com/slauger))
- Allow specifying file paths for manifests and templates too [\#87](https://github.com/voxpupuli/puppet-syntax/pull/87) ([lavagetto](https://github.com/lavagetto))

**Merged pull requests:**

- Test on ruby 2.6 [\#111](https://github.com/voxpupuli/puppet-syntax/pull/111) ([alexjfisher](https://github.com/alexjfisher))
- Adding KMS tags to allowed EYAML methods [\#105](https://github.com/voxpupuli/puppet-syntax/pull/105) ([craigwatson](https://github.com/craigwatson))

## [v2.5.0](https://github.com/voxpupuli/puppet-syntax/tree/v2.5.0) (2019-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.4.3...v2.5.0)

**Implemented enhancements:**

- Support puppet 6.5 [\#106](https://github.com/voxpupuli/puppet-syntax/pull/106) ([alexjfisher](https://github.com/alexjfisher))

## [v2.4.3](https://github.com/voxpupuli/puppet-syntax/tree/v2.4.3) (2019-02-09)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.4.2...v2.4.3)

**Fixed bugs:**

- Revert "search manifests in manifests directory" [\#102](https://github.com/voxpupuli/puppet-syntax/pull/102) ([alexjfisher](https://github.com/alexjfisher))

## [v2.4.2](https://github.com/voxpupuli/puppet-syntax/tree/v2.4.2) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.4.1...v2.4.2)

- Search manifests in manifests directory
- Allow .yml as an extension for YAML files.
- Ensure the pkg directory is always excluded
- Check consistency of ENC blobs in eyaml data

## [v2.4.1](https://github.com/voxpupuli/puppet-syntax/tree/v2.4.1) (2017-06-29)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.4.0...v2.4.1)

- Fix to ensure namespace scope is inherited.
- Cleanly exits when syntax warnings/errors are found instead of failing.

## [v2.4.0](https://github.com/voxpupuli/puppet-syntax/tree/v2.4.0) (2017-03-14)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.3.0...v2.4.0)

- Add check_hiera_keys flag for deep checking of Hiera key name correctness. Thanks @petems.
- Fix Puppet version comparisons for compatibility with Puppet 4.10.
- Fix app_management setting compatibility with Puppet 5.
- Refactor PUPPETVERSION usage to Puppet.version public API.

## [v2.3.0](https://github.com/voxpupuli/puppet-syntax/tree/v2.3.0) (2017-02-01)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.2.0...v2.3.0)

- Add app_management flag for Puppet application orchestration support. Thanks @ipcrm.
- Check all *yaml file extensions, including eyaml. thanks @kjetilho, @rjw1.
- Only test ERB syntax in files with an *.erb extension. Thanks @alexiri.
- Extend README to list specific files and checks implemented. Thanks @petems.
- Refactor Rake filelist generation, add tests. Thanks @kjetilho, @rjw1.

## [v2.2.0](https://github.com/voxpupuli/puppet-syntax/tree/v2.2.0) (2016-12-02)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.1.1...v2.2.0)

- Replace Puppet.initialize_settings with Puppet::Test::TestHelper. Thanks @domcleal #60
  This clears out caches on every test so increases runtime.

## [v2.1.1](https://github.com/voxpupuli/puppet-syntax/tree/v2.1.1) (2016-10-21)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.1.0...v2.1.1)

- Use `$stderr.puts` rather than `warn` and `info` (thanks @mmckinst)
- Allow latest 3.x to validate EPP files (thanks @DavidS)

## [v2.1.0](https://github.com/voxpupuli/puppet-syntax/tree/v2.1.0) (2016-01-18)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v2.0.0...v2.1.0)

- Support Puppet 4. Many thanks to @DavidS
- Support validation of EPP templates. Thanks to @trlinkin
- Test improvements and refactoring, including Travis CI tests against Puppet 4. Thanks to @trlinkin
- Don't error when a tag metaparameter is present. Thank you @dhardy92
- Report the filename of invalid hiera data files. Thanks @danzilio

## [v2.0.0](https://github.com/voxpupuli/puppet-syntax/tree/v2.0.0) (2015-02-26)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v1.4.1...v2.0.0)

- Removed support for Puppet version 2.7.x
- New option, fail_on_deprecation_notices, which defaults to true (compatible
with previous behaviour); thanks @pcfens
- PuppetSyntax::Manifests#check now has two return arguments

## [v1.4.1](https://github.com/voxpupuli/puppet-syntax/tree/v1.4.1) (2015-01-08)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v1.4.0...v1.4.1)

- Support appending to config arrays, thanks @domcleal

## [v1.4.0](https://github.com/voxpupuli/puppet-syntax/tree/v1.4.0) (2014-12-18)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v1.3.0...v1.4.0)

- Rspec 3 is now supported, thanks @tuxmea
- Build error fixed where gem_publisher was used prematurely
- Lazy load Puppet only when it's required, thanks @logicminds

## [v1.3.0](https://github.com/voxpupuli/puppet-syntax/tree/v1.3.0) (2014-08-07)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v1.2.3...v1.3.0)

- Add the ability to pass hieradata_paths array of globs to check
- Check hieradata in modules ('**/data/**/*.yaml') by default

## [v1.2.3](https://github.com/voxpupuli/puppet-syntax/tree/v1.2.3) (2014-08-06)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v1.2.2...v1.2.3)

- Fix puppetlabs_spec_helper warning on Ruby 1.8

## [v1.2.2](https://github.com/voxpupuli/puppet-syntax/tree/v1.2.2) (2014-07-31)

[Full Changelog](https://github.com/voxpupuli/puppet-syntax/compare/v1.2.0...v1.2.2)

- Check and document conflicts with puppetlabs_spec_helper <= 0.7.0

## v1.2.1 (2014-07-23)

- Remove dependency on Puppet from Gemspec (for Puppet Entreprise users).

## v1.2.0 (2014-03-28)

- Optional support for Puppet's future parser.

## v1.1.1 (2014-03-17)

- Ignore exit(1) from Puppet 3.4
- Don't use hardcoded version of parser face.

## v1.1.0 (2013-09-06)

- Syntax checks for Hiera YAML files.
- Improved documentation.

## v1.0.0 (2013-07-04)

- Refactor code to make it easier to test.
- Implement spec tests for syntax checks.
- Pending spec tests for FileList matching.
- Matrix tests for other Ruby/Puppet versions.
- Improve usage example in README.

## v0.0.4 (2013-06-14)

- Fix `$confdir` error for Puppet 3.x

## v0.0.3 (2013-06-11)

- List rake as a dependency.
- Output names of tasks to STDERR.
- Match template paths correctly.
- Add pending spec tests, not yet working.

## v0.0.2 (2013-06-10)

- Fix namespacing of rake tasks.

## v0.0.1 (2013-06-10)

- Initial release


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
