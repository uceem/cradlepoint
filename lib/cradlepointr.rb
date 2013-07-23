require 'json'
require 'rest-client'

require 'cradlepointr/version'

require 'cradlepointr/cradlepoint_object'
require 'cradlepointr/account'
require 'cradlepointr/net_device'
require 'cradlepointr/net_flow'
require 'cradlepointr/router'
require 'cradlepointr/config'

module Cradlepointr

  class << self
    attr_accessor :username, :password, :account, :base_url
  end
  
  @base_url = 'cradlepointecm.com/api/v1'

  def self.make_request(method, url = '', params = {})
    raise 'You need to call Cradlepointr.authenticate(username, password) first.' unless username and password

    parameters = { format: :json }
    headers = { accept: :json, content_type: :json }

    response = case method
               when :get then RestClient.get()
               when :configs then get_configs
               else false
               end
    
    response ? handle_response(response) : false
  rescue RestClient::Exception => e
    return case e.code
           when 400 then { data: :unavailable }
           when 401 then { data: :unavailable }
           when 403 then { data: :unavailable }
           when 404 then { data: :unavailable }
           when 500 then { data: :unavailable }
           else raise(e)
           end
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
    rescue JSON::ParserError, TypeError
      puts response.inspect
      raise "Cradlepointr received an invalid json response."
    end
    
    case response.code
    when 200, 302 then parsed_response
    when 400, 401 then false
    when 500 then false
    else false
    end
  end
end