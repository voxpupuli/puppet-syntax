require 'yaml'

module PuppetSyntax
  class Hiera
    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)

      errors = []

      filelist.each do |hiera_file|
        begin
          YAML.load_file(hiera_file)
        rescue Exception => error
          errors << error
        end
       end

      errors.map! { |e| e.to_s }

      #this check will fail when embedding heira lookups in heira
      #rejecting this error is not great but functional
      errors.reject! { |e|
        e =~ /found character that cannot start any token while scanning for the next token/
      }

      errors
    end
  end
end
