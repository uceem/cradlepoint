require 'rubygems'
require 'bundler/setup'
require 'rspec'

require 'json'
require 'rest-client'

require 'cradlepointr'

RSpec.configure do |config|
  config.color_enabled = true
end

USERNAME ||= ENV['ecm_username']
PASSWORD ||= ENV['evm_password']

raise 'REQUIRED ENV variables: [ecm_username and ecm_password] in order to run the specs.' unless USERNAME and PASSWORD