require 'rspec'
require 'puppet-syntax'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
