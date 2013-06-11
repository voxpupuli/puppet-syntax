require 'rake'
require 'erb'
require 'stringio'

module PuppetSyntax
  class Templates
    def check
      # We now have to redirect STDERR in order to capture warnings.
      $stderr = warnings = StringIO.new()
      errors = []

      # Templates don't have to have a .erb extension
      matched_files = FileList["**/templates/**/*"].exclude(*PuppetSyntax.exclude_paths)
      matched_files.reject! { |f| File.directory?(f) }
      matched_files.each do |erb_file|
        begin
          erb = ERB.new(File.read(erb_file), nil, '-')
          erb.filename = erb_file
          erb.result
        rescue NameError
          # This is normal because we don't have the variables that would
          # ordinarily be bound by the parent Puppet manifest.
        rescue StandardError, SyntaxError => error
          errors << error
        end
      end

      $stderr = STDERR
      errors << warnings.string unless warnings.string.empty?
      errors
    end
  end
end
