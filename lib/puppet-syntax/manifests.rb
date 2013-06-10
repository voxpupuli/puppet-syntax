require 'puppet'
require 'puppet/face'

module PuppetSyntax
  class Manifests
    def validate_manifest(file)
      Puppet::Face[:parser, '0.0.1'].validate(file)
    end

    def check
      errors = []

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
