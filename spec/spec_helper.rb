require 'rubygems'
require 'bundler/setup'
require 'rspec'

require 'json'
require 'rest-client'

require 'cradlepointr'

RSpec.configure do |config|
  config.color_enabled = true
end

USERNAME   ||= ENV['ECM_USERNAME']
PASSWORD   ||= ENV['ECM_PASSWORD']
ROUTER_ID  ||= ENV['ECM_ROUTER_ID']
ACCOUNT_ID ||= ENV['ECM_ACCOUNT_ID']
ROUTER_MAC ||= ENV['ECM_ROUTER_MAC']

unless USERNAME and PASSWORD and ROUTER_ID and ACCOUNT_ID
  raise 'REQUIRED ENV variables: [ECM_USERNAME, ECM_PASSWORD, ECM_ROUTER_ID, ECM_ACCOUNT_ID] in order to run the specs.'
end

def authenticate_with_valid_credentials(username = USERNAME, password = PASSWORD)
  Cradlepointr.authenticate(username, password)
end

alias :login :authenticate_with_valid_credentials

def logout
  Cradlepointr.username = nil
  Cradlepointr.password = nil
end