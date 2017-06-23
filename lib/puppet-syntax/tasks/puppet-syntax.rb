require 'puppet-syntax'
require 'rake'
require 'rake/tasklib'

module PuppetSyntax
  class RakeTask < ::Rake::TaskLib
    def filelist(paths)
      files = FileList[paths]
      files.reject! { |f| File.directory?(f) }
      files.exclude(*PuppetSyntax.exclude_paths)
    end

    def filelist_manifests
      filelist("**/*.pp")
    end

    def filelist_templates
      filelist(["**/templates/**/*.erb", "**/templates/**/*.epp"])
    end

    def filelist_hiera_yaml
      filelist(PuppetSyntax.hieradata_paths)
    end

    def initialize(*args)
      desc 'Syntax check Puppet manifests and templates'
      task :syntax => [
        'syntax:check_puppetlabs_spec_helper',
        'syntax:manifests',
        'syntax:templates',
        'syntax:hiera',
      ]

      namespace :syntax do
        task :check_puppetlabs_spec_helper do
          psh_present = task(:syntax).actions.any? { |a|
            a.inspect.match(/puppetlabs_spec_helper\/rake_tasks\.rb:\d+/)
          }

          if psh_present
            $stderr.puts <<-EOS
[WARNING] A conflicting :syntax rake task has been defined by
puppetlabs_spec_helper/rake_tasks. You should either disable this or upgrade
to puppetlabs_spec_helper >= 0.8.0 which now uses puppet-syntax.
            EOS
          end
        end

        desc 'Syntax check Puppet manifests'
        task :manifests do |t|
          if Puppet.version.to_i >= 4 and PuppetSyntax.future_parser
            $stderr.puts <<-EOS
[INFO] Puppet 4 has been detected and `future_parser` has been set to
'true'. The `future_parser setting will be ignored.
            EOS
          end
          if Puppet::Util::Package.versioncmp(Puppet.version, '4.3.0') < 0 and PuppetSyntax.app_management
            $stderr.puts <<-EOS
[WARNING] Puppet `app_management` has been detected but the Puppet
version is less then 4.3.  The `app_management` setting will be ignored.
            EOS
          end

          $stderr.puts "---> #{t.name}"

          c = PuppetSyntax::Manifests.new
          output, has_errors = c.check(filelist_manifests)
          $stdout.puts "#{output.join("\n")}\n" unless output.empty?
          exit 1 if has_errors || ( output.any? && PuppetSyntax.fail_on_deprecation_notices )
        end

        desc 'Syntax check Puppet templates'
        task :templates do |t|
          $stderr.puts "---> #{t.name}"

          c = PuppetSyntax::Templates.new
          errors = c.check(filelist_templates)
          $stdout.puts "#{errors.join("\n")}\n" unless errors.empty?
          exit 1 unless errors.empty?
        end

        desc 'Syntax check Hiera config files'
        task :hiera => [
          'syntax:hiera:yaml',
        ]

        namespace :hiera do
          task :yaml do |t|
            $stderr.puts "---> #{t.name}"
            c = PuppetSyntax::Hiera.new
            errors = c.check(filelist_hiera_yaml)
            $stdout.puts "#{errors.join("\n")}\n" unless errors.empty?
            exit 1 unless errors.empty?
          end
        end
      end
    end
  end
end

PuppetSyntax::RakeTask.new
