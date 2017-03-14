require "puppet-syntax/version"
require "puppet-syntax/manifests"
require "puppet-syntax/templates"
require "puppet-syntax/hiera"
require "puppet/version"

module PuppetSyntax
  @exclude_paths = []
  @future_parser = false
  @hieradata_paths = [
    "**/data/**/*.*yaml",
    "hieradata/**/*.*yaml",
    "hiera*.*yaml"
  ]
  @fail_on_deprecation_notices = true
  @app_management = Puppet.version.to_i >= 5 ? true : false
  @check_hiera_keys = false

  class << self
    attr_accessor :exclude_paths,
                  :future_parser,
                  :hieradata_paths,
                  :fail_on_deprecation_notices,
                  :epp_only,
                  :check_hiera_keys
    attr_reader :app_management

    def app_management=(app_management)
      raise 'app_management cannot be disabled on Puppet 5 or higher' if Puppet.version.to_i >= 5 && !app_management
      @app_management = app_management
    end
  end
end
