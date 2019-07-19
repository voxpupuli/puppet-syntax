require "puppet-syntax/version"
require "puppet-syntax/manifests"
require "puppet-syntax/templates"
require "puppet-syntax/hiera"

module PuppetSyntax
  @exclude_paths = []
  @hieradata_paths = [
    "**/data/**/*.*{yaml,yml}",
    "hieradata/**/*.*{yaml,yml}",
    "hiera*.*{yaml,yml}"
  ]
  @fail_on_deprecation_notices = true
  @check_hiera_keys = false

  class << self
    attr_accessor :exclude_paths,
                  :hieradata_paths,
                  :fail_on_deprecation_notices,
                  :epp_only,
                  :check_hiera_keys
  end
end
