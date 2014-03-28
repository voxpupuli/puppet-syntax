require 'puppet'
require 'puppet/face'

module PuppetSyntax
  class Manifests
    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)

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

      filelist.each do |puppet_file|
        begin
          validate_manifest(puppet_file)
        rescue SystemExit
          # Disregard exit(1) from face.
        rescue => error
          errors << error
        end
      end

      Puppet::Util::Log.close_all
      errors.map! { |e| e.to_s }

      # Exported resources will raise warnings when outside a puppetmaster.
      errors.reject! { |e|
        e =~ /^You cannot collect( exported resources)? without storeconfigs being set/
      }

      errors
    end

    private
    def validate_manifest(file)
      Puppet[:parser] = 'future' if PuppetSyntax.future_parser
      Puppet::Face[:parser, :current].validate(file)
    end
  end
end
