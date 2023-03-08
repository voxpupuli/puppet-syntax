require 'yaml'
require 'base64'

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

    # Recurse through complex data structures.  Return on first error.
    def check_eyaml_data(name, val)
      error = nil
      if val.is_a? String
        err = check_eyaml_blob(val)
        error = "Key #{name} #{err}" if err
      elsif val.is_a? Array
        val.each_with_index do |v, idx|
          error = check_eyaml_data("#{name}[#{idx}]", v)
          break if error
        end
      elsif val.is_a? Hash
        val.each do |k,v|
          error = check_eyaml_data("#{name}['#{k}']", v)
          break if error
        end
      end
      error
    end

    def check_eyaml_blob(val)
      # strip newlines and extra spaces
      val.gsub!(/\n/, '')
      val.gsub!(/\s+/, '')
      
      encodes = val.scan(/ENC\[.*?\]/)

      # Return if there's no encoded material
      return if encodes.length == 0

      encodes.each do |n|
        match = n.match(/ENC\[(.+),(.+)\]/)
        if match == nil
          return "has invalid eyaml encoded format"
        end

        return "has unknown eyaml method #{match[1]}" unless ['PKCS7','GPG','GKMS','KMS'].include? match[1]

        return "has unpadded or truncated base64 data" unless match[2].length % 4 == 0

        return "has corrupt base64 data" unless match[2].match?(/^[a-zA-Z0-9+\/=]+$/)
      end
      return
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
            eyaml_msg = check_eyaml_data(k, v)
            errors << "WARNING: #{hiera_file}: #{eyaml_msg}" if eyaml_msg
          end
        end
      end

      errors.map! { |e| e.to_s }

      errors
    end
  end
end
