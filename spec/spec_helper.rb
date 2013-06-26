require 'rspec'
require 'puppet-syntax'

def fixture_templates(list)
  fixture_files(list, 'templates')
end

def fixture_manifests(list)
  fixture_files(list, 'manifests')
end

def fixture_files(list, path)
  list = [list].flatten
  list.map { |f| File.expand_path("../fixtures/test_module/#{path}/#{f}", __FILE__) }
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
