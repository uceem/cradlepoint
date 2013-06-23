require 'json'
require 'rest-client'

require 'cradlepointr/version'

require 'cradlepointr/cradlepoint_object'
require 'cradlepointr/account'
require 'cradlepointr/net_device'
require 'cradlepointr/router'
require 'cradlepointr/config'

module Cradlepointr

  class << self
    attr_accessor :username, :password, :account, :base_url
  end
  
  @base_url = 'beta.cradlepointecm.com/api/v1'

  def self.make_request(method, params = {})
    raise 'You need to call Cradlepointr.authenticate(username, password) first.' unless username and password

    response = case method
               when :routers then get_routers
               when :configs then get_configs
               else false
               end
    
    response ? handle_response(response) : false
  end
  
  def self.authenticate(username, password)
    self.username = username
    self.password = password
    true
  end
  
  def self.url_prepend
    "https://#{ @username }:#{ @password }@"
  end
  
  def self.url_append
    "?format=json"
  end
  
  def self.handle_response(response)
    begin
      parsed_response = JSON.parse(response)
    rescue JSON::ParserError
      raise 'Cradlepointr received an invalid json response.'
    end
    
    case response.code
    when 200, 302 then parsed_response
    when 400, 401 then false
    when 500 then false
    else false
    end
  end
end