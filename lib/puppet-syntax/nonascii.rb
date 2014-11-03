# See the following for why this exists:
# - https://tickets.puppetlabs.com/browse/PUP-1031
# - https://docs.puppetlabs.com/guides/troubleshooting.html#my-catalog-wont-compile-andor-my-code-is-behaving-unpredictably-whats-wrong
#
module PuppetSyntax
  class NonASCII
    def check(filelist)
      raise "Expected an array of files" unless filelist.is_a?(Array)

      errors = []

      filelist.each do |filename|
        File.open(filename) do |file|
          file.each_line.with_index do |line, index|
            unless line.ascii_only?
              errors << "#{filename}:#{index + 1}: Non-ASCII characters: #{line.chomp}"
            end
          end
        end
      end

      errors
    end
  end
end
