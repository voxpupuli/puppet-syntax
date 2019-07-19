module PuppetSyntax
  class Manifests
    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)
      require 'puppet_pal'

      output = []

      Puppet::Pal.in_tmp_environment('pal_env', modulepath: [], facts: {}) do |pal|
        pal.with_script_compiler do |compiler|
          filelist.each do |puppet_file|
            begin
              unless compiler.parse_file(puppet_file)
                output << "Empty AST for #{puppet_file}"
              end
            rescue Exception => ex
              output << ex
            end
          end
        end
      end

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
    end
  end
end
