require 'yaml'

module PuppetSyntax
  class Hiera

    def check_hiera_key(key)
      if key.is_a? Symbol
        if key.to_s.start_with?(':')
          return "Puppet automatic lookup will not use leading '::'"
        elsif key !~ /^[a-z]+$/ # we allow Hiera's own configuration
          return "Puppet automatic lookup will not look up symbols"
        end
      elsif key !~ /^[a-z][a-z0-9_]+(::[a-z][a-z0-9_]+)*$/
        if key =~ /[^:]:[^:]/
          # be extra helpful
          return "Looks like a missing colon"
        else
          return "Not a valid Puppet variable name for automatic lookup"
        end
      end
    end

    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)

      errors = []

      filelist.each do |hiera_file|
        begin
          yamldata = YAML.load_file(hiera_file)
        rescue Exception => error
          errors << "ERROR: Failed to parse #{hiera_file}: #{error}"
          next
        end
        if yamldata
          yamldata.each do |k,v|
            if PuppetSyntax.check_hiera_keys
              key_msg = check_hiera_key(k)
              errors << "WARNING: #{hiera_file}: Key :#{k}: #{key_msg}" if key_msg
            end
          end
        end
      end

      errors.map! { |e| e.to_s }

      errors
    end
  end
end
