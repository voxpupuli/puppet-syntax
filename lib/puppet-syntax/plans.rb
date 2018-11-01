require_relative 'manifests'

module PuppetSyntax
  class Plans < Manifests
    private
    def validate_manifest(file)
      Puppet[:tasks] = true
      Puppet::Face[:parser, :current].validate(file)
    end
  end
end
