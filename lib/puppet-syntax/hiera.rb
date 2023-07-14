require 'yaml'
require 'base64'

module PuppetSyntax
  class Hiera
    def check_hiera_key(key)
      if key.is_a? Symbol
        if key.to_s.start_with?(':')
          "Puppet automatic lookup will not use leading '::'"
        elsif !/^[a-z]+$/.match?(key) # we allow Hiera's own configuration
          'Puppet automatic lookup will not look up symbols'
        end
      elsif !/^[a-z][a-z0-9_]+(::[a-z][a-z0-9_]+)*$/.match?(key)
        return 'Looks like a missing colon' if /[^:]:[^:]/.match?(key)

        # be extra helpful

        'Not a valid Puppet variable name for automatic lookup'

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
        val.each do |k, v|
          error = check_eyaml_data("#{name}['#{k}']", v)
          break if error
        end
      end
      error
    end

    def check_eyaml_blob(val)
      return unless /^ENC\[/.match?(val)

      val.sub!('ENC[', '')
      val.gsub!(/\s+/, '')
      return 'has unterminated eyaml value' unless /\]$/.match?(val)

      val.sub!(/\]$/, '')
      method, base64 = val.split(',')
      if base64.nil?
        base64 = method
        method = 'PKCS7'
      end

      return "has unknown eyaml method #{method}" unless %w[PKCS7 GPG GKMS KMS].include? method
      return 'has unpadded or truncated base64 data' unless base64.length % 4 == 0

      # Base64#decode64 will silently ignore characters outside the alphabet,
      # so we check resulting length of binary data instead
      pad_length = base64.gsub(/[^=]/, '').length
      return unless Base64.decode64(base64).length != (base64.length * 3 / 4) - pad_length

      'has corrupt base64 data'
    end

    def check(filelist)
      raise 'Expected an array of files' unless filelist.is_a?(Array)

      errors = []

      yamlargs = (Psych::VERSION >= '4.0') ? { aliases: true } : {}

      filelist.each do |hiera_file|
        begin
          yamldata = YAML.load_file(hiera_file, **yamlargs)
        rescue Exception => e
          errors << "ERROR: Failed to parse #{hiera_file}: #{e}"
          next
        end
        next unless yamldata

        yamldata.each do |k, v|
          if PuppetSyntax.check_hiera_keys
            key_msg = check_hiera_key(k)
            errors << "WARNING: #{hiera_file}: Key :#{k}: #{key_msg}" if key_msg
          end
          eyaml_msg = check_eyaml_data(k, v)
          errors << "WARNING: #{hiera_file}: #{eyaml_msg}" if eyaml_msg
        end
      end

      errors.map! { |e| e.to_s }

      errors
    end
  end
end
