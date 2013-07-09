require "puppet-syntax/version"
require "puppet-syntax/manifests"
require "puppet-syntax/templates"
require "puppet-syntax/hiera"

module PuppetSyntax
  class << self
    attr_accessor :exclude_paths

    def exclude_paths
      @exclude_paths || []
    end
  end
end
