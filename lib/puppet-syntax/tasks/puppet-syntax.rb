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
        'syntax:hiera',
      ]

      namespace :syntax do
        desc 'Syntax check Puppet manifests'
        task :manifests do |t|
          $stderr.puts "---> #{t.name}"
          files = FileList["**/*.pp"]
          files.reject! { |f| File.directory?(f) }
          files = files.exclude(*PuppetSyntax.exclude_paths)

          c = PuppetSyntax::Manifests.new
          errors = c.check(files)
          fail errors.join("\n") unless errors.empty?
        end

        desc 'Syntax check Puppet templates'
        task :templates do |t|
          $stderr.puts "---> #{t.name}"
          files = FileList["**/templates/**/*"]
          files.reject! { |f| File.directory?(f) }
          files = files.exclude(*PuppetSyntax.exclude_paths)

          c = PuppetSyntax::Templates.new
          errors = c.check(files)
          fail errors.join("\n") unless errors.empty?
        end

        desc 'Syntax check Hiera config files'
        task :hiera => [
          'syntax:hiera:yaml',
        ]

        namespace :hiera do
          task :yaml do |t|
            $stderr.puts "---> #{t.name}"
            files = FileList["hieradata/**/*.yaml", "hiera*.yaml"]
            files.reject! { |f| File.directory?(f) }
            files = files.exclude(*PuppetSyntax.exclude_paths)

            c = PuppetSyntax::Hiera.new
            errors = c.check(files)
            fail errors.join("\n") unless errors.empty?
          end
        end
      end
    end
  end
end

PuppetSyntax::RakeTask.new
