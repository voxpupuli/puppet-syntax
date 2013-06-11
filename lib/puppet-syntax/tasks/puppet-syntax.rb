require 'puppet-syntax'
require 'rake'
require 'rake/tasklib'

module PuppetSyntax
  class RakeTask < ::Rake::TaskLib
    def initialize(*args)
      desc 'Syntax check Puppet manifests and templates'
      task :syntax => [
        'syntax:manifests',
        'syntax:templates',
      ]

      namespace :syntax do
        desc 'Syntax check Puppet manifests'
        task :manifests do |t|
          $stderr.puts "---> #{t.name}"
          c = PuppetSyntax::Manifests.new
          errors = c.check
          fail errors.join("\n") unless errors.empty?
        end

        desc 'Syntax check Puppet templates'
        task :templates do |t|
          $stderr.puts "---> #{t.name}"
          c = PuppetSyntax::Templates.new
          errors = c.check
          fail errors.join("\n") unless errors.empty?
        end
      end
    end
  end
end

PuppetSyntax::RakeTask.new
