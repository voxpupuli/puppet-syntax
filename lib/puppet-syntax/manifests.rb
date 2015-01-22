require 'pry'
module PuppetSyntax
  class Manifests
    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)
      require 'puppet'
      require 'puppet/face'

      output = []
      log_collector = []
      validator_errors = []

      # FIXME: We shouldn't need to do this. puppet/face should. See:
      # - http://projects.puppetlabs.com/issues/15529
      # - https://groups.google.com/forum/#!topic/puppet-dev/Yk0WC1JZCg8/discussion
      if (Puppet::PUPPETVERSION.to_i >= 3 && !Puppet.settings.app_defaults_initialized?)
        Puppet.initialize_settings
      end

      # Catch syntax warnings.
      Puppet::Util::Log.newdestination(Puppet::Test::LogCollector.new(log_collector))
      Puppet::Util::Log.level = :warning

      filelist.each do |puppet_file|
        begin
          validate_manifest(puppet_file)
        rescue SystemExit
          # Disregard exit(1) from face.
        rescue => error
          validator_errors << error
        end
      end

      Puppet::Util::Log.close_all

      # Exported resources will raise warnings when outside a puppetmaster.
      log_collector.reject! { |e|
        e.message =~ /^You cannot collect( exported resources)? without storeconfigs being set/
      }

      has_log_errors = log_collector.collect { |e| e.level == :err }.any?
      has_validator_errors = validator_errors.any?

      has_errors = has_log_errors || has_validator_errors
      has_warnings = log_collector.collect { |e| e.level == :warning }.any?

      output_log = log_collector.map { |e| e.to_s }
      output_validator = validator_errors .map { |e| e.to_s }

      output.concat(output_validator)
      output.concat(output_log)

      return output, has_errors, has_warnings
    end

    private
    def validate_manifest(file)
      Puppet[:parser] = 'future' if PuppetSyntax.future_parser
      Puppet::Face[:parser, :current].validate(file)
    end
  end
end
