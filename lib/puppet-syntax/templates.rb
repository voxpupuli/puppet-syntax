require 'erb'
require 'puppet'
require 'stringio'

module PuppetSyntax
  class Templates
    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)

      # We now have to redirect STDERR in order to capture warnings.
      $stderr = warnings = StringIO.new()
      errors = []

      filelist.each do |file|
        if File.extname(file) == '.epp' or PuppetSyntax.epp_only
          errors.concat validate_epp(file)
        else
          errors.concat validate_erb(file)
        end
      end

      $stderr = STDERR
      errors << warnings.string unless warnings.string.empty?
      errors.map! { |e| e.to_s }

      errors
    end

    def validate_epp(filename)
      if Puppet::PUPPETVERSION.to_f < 3.7
        raise "Cannot validate EPP without Puppet 4 or future parser (3.7+)"
      end

      require 'puppet/pops'
      errors = []
      begin
        parser = Puppet::Pops::Parser::EvaluatingParser::EvaluatingEppParser.new()
        parser.parse_file(filename)
      rescue => detail
        errors << detail
      end

      errors
    end

    def validate_erb(filename)
      errors = []

      begin
        erb = ERB.new(File.read(filename), nil, '-')
        erb.filename = filename
        erb.result
      rescue NameError => error
        # This is normal because we don't have the variables that would
        # ordinarily be bound by the parent Puppet manifest.
      rescue TypeError
        # This is normal because we don't have the variables that would
        # ordinarily be bound by the parent Puppet manifest.
      rescue SyntaxError => error
        errors << error
      end

      errors
    end
  end
end
