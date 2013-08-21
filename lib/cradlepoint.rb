require 'json'
require 'rest-client'

require 'cradlepoint/version'

require 'utils/hash_helpers'

require 'cradlepoint/cradlepoint_object'
require 'cradlepoint/account'
require 'cradlepoint/net_device'
require 'cradlepoint/net_flow'
require 'cradlepoint/router'
require 'cradlepoint/config'

module Cradlepoint
  
  class << self
    attr_accessor :username, :password, :account, :base_url
  end
  
  @base_url = 'cradlepointecm.com/api/v1'

  def self.make_request(method, url = '', params = {})
    raise 'You need to call Cradlepoint.authenticate(username, password) first.' unless username and password

    params.merge!(format: :json)
    headers = { accept: :json, content_type: :json }

    response = case method
               when :get then RestClient.get(url, params: params, headers: headers)
               else return false
               end
    
    handle_response(response)
  rescue RestClient::Exception => e
    puts "RestClient::Exception received: #{ e.response.code }"
    return case e.response.code
           when 400 then { success: false, error_code: 400, error: e }
           when 401 then { success: false, error_code: 401, error: e }
           when 403 then { success: false, error_code: 403, error: e }
           when 404 then { success: false, error_code: 404, error: e }
           when 500 then { success: false, error_code: 500, error: e }
           else raise(e) # Not an error we are expecting.
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
  
  def self.handle_response(response)
    begin
      parsed_response = JSON.parse(response)
    rescue JSON::ParserError, TypeError
      raise "Cradlepoint received an invalid json response."
    end
    
    parsed_response['success'] ? 
      Utils::HashHelpers.symbolize_keys(parsed_response['data']) : 
      raise("Unsuccessful response received: #{ parsed_response.inspect }")  # TODO: Handle more elegantly.
  end
end
