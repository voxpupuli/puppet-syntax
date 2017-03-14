module PuppetSyntax
  class Manifests
    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)
      require 'puppet'
      require 'puppet/face'
      require 'puppet/test/test_helper'

      output = []

      if Puppet::Test::TestHelper.respond_to?(:initialize) # 3.1+
        Puppet::Test::TestHelper.initialize
      end
      Puppet::Test::TestHelper.before_all_tests
      called_before_all_tests = true

      # Catch syntax warnings.
      Puppet::Util::Log.newdestination(Puppet::Test::LogCollector.new(output))
      Puppet::Util::Log.level = :warning

      filelist.each do |puppet_file|
        Puppet::Test::TestHelper.before_each_test
        begin
          validate_manifest(puppet_file)
        rescue SystemExit
          # Disregard exit(1) from face.
        rescue => error
          output << error
        ensure
          Puppet::Test::TestHelper.after_each_test
        end
      end

      Puppet::Util::Log.close_all
      output.map! { |e| e.to_s }

      # Exported resources will raise warnings when outside a puppetmaster.
      output.reject! { |e|
        e =~ /^You cannot collect( exported resources)? without storeconfigs being set/
      }

      # tag parameter in class raise warnings notice in output that prevent from succeed
      output.reject! { |e|
        e =~ /^tag is a metaparam; this value will inherit to all contained resources in the /
      }

      deprecations = output.select { |e|
        e =~ /^Deprecation notice:|is deprecated/
      }

      # Errors exist if there is any output that isn't a deprecation notice.
      has_errors = (output != deprecations)

      return output, has_errors
    ensure
      Puppet::Test::TestHelper.after_all_tests if called_before_all_tests
    end

    private
    def validate_manifest(file)
      Puppet[:parser] = 'future' if PuppetSyntax.future_parser and Puppet.version.to_i < 4
      Puppet[:app_management] = true if PuppetSyntax.app_management && (Puppet::Util::Package.versioncmp(Puppet.version, '4.3.0') >= 0 && Puppet.version.to_i < 5)
      Puppet::Face[:parser, :current].validate(file)
    end
  end
end
