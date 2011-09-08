require 'grapiw'
require 'mocha'
require 'rspec'

LOGGER = Logger.new($stdout)

RSpec.configure do |config|
  config.mock_with(:mocha)
  config.color_enabled = true
  config.formatter     = 'documentation'
end