require 'puppet-syntax/version'

module PuppetSyntax
  autoload :Hiera, 'puppet-syntax/hiera'
  autoload :Manifests, 'puppet-syntax/manifests'
  autoload :Templates, 'puppet-syntax/templates'

  @exclude_paths = []
  @hieradata_paths = [
    '**/data/**/*.*{yaml,yml}',
    'hieradata/**/*.*{yaml,yml}',
    'hiera*.*{yaml,yml}',
  ]
  @manifests_paths = [
    '**/*.pp',
  ]
  @templates_paths = [
    '**/templates/**/*.erb',
    '**/templates/**/*.epp',
  ]
  @fail_on_deprecation_notices = true
  @check_hiera_keys = false
  @check_hiera_data = false

  class << self
    attr_accessor :exclude_paths,
                  :hieradata_paths,
                  :manifests_paths,
                  :templates_paths,
                  :fail_on_deprecation_notices,
                  :epp_only,
                  :check_hiera_keys,
                  :check_hiera_data
  end
end
