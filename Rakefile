require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')

task default: [:spec]
begin
  require 'github_changelog_generator/task'
  require 'puppet-syntax/version'
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    version = PuppetSyntax::VERSION
    config.future_release = "v#{version}" if /^\d+\.\d+.\d+$/.match?(version)
    config.header = "# Changelog\n\nAll notable changes to this project will be documented in this file."
    config.exclude_labels = %w[duplicate question invalid wontfix wont-fix modulesync skip-changelog github_actions]
    config.user = 'voxpupuli'
    config.project = 'puppet-syntax'
  end
rescue LoadError
end

begin
  require 'voxpupuli/rubocop/rake'
rescue LoadError
  # the voxpupuli-rubocop gem is optional
end
