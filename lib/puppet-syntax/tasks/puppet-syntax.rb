require 'puppet-syntax'
require 'rake'
require 'rake/tasklib'

module PuppetSyntax
  class RakeTask < ::Rake::TaskLib
    def initialize(*args)
      desc 'Syntax check Puppet manifests and templates'
      task :syntax => [
        :syntax_manifests,
        :syntax_templates,
      ]

      desc 'Syntax check Puppet manifests'
      task :syntax_manifests do
      end

      desc 'Syntax check Puppet templates'
      task :syntax_templates do
      end
    end
  end
end

PuppetSyntax::RakeTask.new
