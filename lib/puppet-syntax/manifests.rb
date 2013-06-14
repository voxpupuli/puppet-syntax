require 'rake'
require 'puppet'
require 'puppet/face'

module PuppetSyntax
  class Manifests
    def validate_manifest(file)
      Puppet::Face[:parser, '0.0.1'].validate(file)
    end

    def check
      errors = []

      # FIXME: We shouldn't need to do this. puppet/face should. See:
      # - http://projects.puppetlabs.com/issues/15529
      # - https://groups.google.com/forum/#!topic/puppet-dev/Yk0WC1JZCg8/discussion
      if (Puppet::PUPPETVERSION.to_i >= 3 && !Puppet.settings.app_defaults_initialized?)
        Puppet.initialize_settings
      end

      # Catch syntax warnings.
      Puppet::Util::Log.newdestination(Puppet::Test::LogCollector.new(errors))
      Puppet::Util::Log.level = :warning

      matched_files = FileList["**/*.pp"].exclude(*PuppetSyntax.exclude_paths)
      matched_files.each do |puppet_file|
        begin
          validate_manifest(puppet_file)
        rescue => error
          errors << error
        end
      end

      # Exported resources will raise warnings when outside a puppetmaster.
      Puppet::Util::Log.close_all
      errors.reject! { |e|
        e.to_s =~ /^You cannot collect( exported resources)? without storeconfigs being set/
      }

      errors
    end
  end
end
