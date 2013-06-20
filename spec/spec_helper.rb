require 'rubygems'
require 'bundler/setup'
require 'rspec'

require 'json'
require 'rest-client'

require 'cradlepointr'

RSpec.configure do |config|
  config.color_enabled = true
end

USERNAME ||= ENV['ECM_USERNAME']
PASSWORD ||= ENV['ECM_PASSWORD']
ROUTER_ID ||= ENV['ECM_ROUTER_ID']

unless USERNAME and PASSWORD and ROUTER_ID
  raise 'REQUIRED ENV variables: [ECM_USERNAME, ECM_PASSWORD, ECM_ROUTER_ID] in order to run the specs.'
end

def authenticate_with_valid_credentials(username = USERNAME, password = PASSWORD)
  Cradlepointr.authenticate(username, password)
end