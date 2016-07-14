require 'yaml'
require 'base64'

module PuppetSyntax
  class Hiera
    def check_hiera_key(key)
      if key.is_a? Symbol
        if key =~ /^:/
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

    # Recurse through complex data structures
    def check_eyaml_data(name, val)
      errors = []
      if val.is_a? String
        err = check_eyaml_blob(val)
        errors << "Key #{name} #{err}" if err
      elsif val.is_a? Array
        val.each_with_index do |v, idx|
          errors += check_eyaml_data("#{name}[#{idx}]", v)
        end
      elsif val.is_a? Hash
        val.each do |v,k|
          errors += check_eyaml_data("#{name}['#{v}']", k)
        end
      end
      errors
    end

    def check_eyaml_blob(val)
      return unless val =~ /^ENC\[/

      val.sub!('ENC[', '')
      val.gsub!(/\s+/, '')
      if val !~ /\]$/
        return "has unterminated eyaml value"
      else
        val.sub!(/\]$/, '')
        method, base64 = val.split(/,/)
        if base64 == nil
          base64 = method
          method = 'PKCS7'
        end

        return "has unknown eyaml method #{method}" unless ['PKCS7','GPG'].include? method
        return "has unpadded or truncated base64 data" unless base64.length % 4 == 0

        # Base64#decode64 will silently ignore characters outside the alphabet,
        # so we check resulting length of binary data instead
        if Base64.decode64(base64).length != base64.length * 3 / 4
          return "has corrupt base64 data"
        end
      end
    end

    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)

      errors = []

      filelist.each do |hiera_file|
        begin
          data = YAML.load_file(hiera_file)
        rescue Exception => error
          errors << "ERROR: Failed to parse #{hiera_file}: #{error}"
          next
        end
        data.each do |k,v|
          if PuppetSyntax.check_hiera_keys
            errors += Array(check_hiera_key(k)).map do |msg|
              "WARNING: #{hiera_file}: Key :#{k}: #{msg}"
            end
          end
          if PuppetSyntax.check_eyaml
            errors += check_eyaml_data(k, v).map do |msg|
              "ERROR: #{hiera_file}: #{msg}"
            end
          end
        end
      end

      errors.map! { |e| e.to_s }

      errors
    end
  end
end
