require 'rspec'
require 'puppet-syntax'

def fixture_files(list)
  list = [list].flatten
  list.map { |f| File.expand_path("../fixtures/#{f}", __FILE__) }
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
