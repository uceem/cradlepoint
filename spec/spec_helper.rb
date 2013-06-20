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

raise 'REQUIRED ENV variables: [ECM_USERNAME and ECM_PASSWORD] in order to run the specs.' unless USERNAME and PASSWORD

def authenticate_with_valid_credentials(username = USERNAME, password = PASSWORD)
  Cradlepointr.authenticate(username, password)
end