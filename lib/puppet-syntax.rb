require "puppet-syntax/version"
require "puppet-syntax/manifests"
require "puppet-syntax/templates"
require "puppet-syntax/hiera"

module PuppetSyntax
  @exclude_paths = []
  @future_parser = false
  @hieradata_paths = ["**/data/**/*.yaml", "hieradata/**/*.yaml", "hiera*.yaml"]

  class << self
    attr_accessor :exclude_paths, :future_parser, :hieradata_paths
  end
end
