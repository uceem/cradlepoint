require 'json'
require 'rest_client'
require 'cradlepointr/version'
# require 'cradlepointer/router'
# require 'cradlepointer/config'


module Cradlepointr
  
  @@base_url = 'beta.cradlepointecm.com/api/v1/'
  @@username = nil
  @@password = nil
  
  def self.make_request(method, params = {})
    response = case method
               when :routers then get_routers
               when :configs then get_configs
               else raise 'No Cradlepointr method specified.'
               end
    
    handle_response(response)
  end
  
  def self.authenticate(username, password)
    @@username = username
    @@password = password
    true
  end
  
  def self.url_prepend
    "https://#{ @@username }:#{ @@password }@"
  end
  
  def self.url_append
    "?format=json"
  end
  
  def self.get_routers
    RestClient.get("#{ url_prepend }#{ @@base_url }/routers#{ url_append }")
  end
  
  def self.do_config(router)
    config_editor = create_config_editor(router)
    update_config_editor(router, config_editor['data']['id'])
    remove_config_editor(config_editor['data']['id'])
  end
  
  def self.create_config_editor(router)
    handle_response RestClient.post("#{ url_prepend }#{ @@base_url }/configuration_editors/",
                                    router.config.create_config_editor_data.to_json,
                                    content_type: :json,
                                    accept: :json)
  end
  
  def self.update_config_editor(router, config_editor_id)
    handle_response RestClient.put("#{ url_prepend }#{ @@base_url }/configuration_editors/#{ config_editor_id }/",
                                   router.config.update_config_editor_data(config_editor_id).to_json,
                                   content_type: :json,
                                   accept: :json)
  end
  
  def self.remove_config_editor(config_editor_id)
    handle_response RestClient.delete("#{ url_prepend }#{ @@base_url }/configuration_editors/#{ config_editor_id }/",
                                      content_type: :json,
                                      accept: :json)
  end
  
  def self.get_config_by_id(id)
    handle_response RestClient.get("#{ url_prepend }#{ @@base_url }/routers/#{ id }/configuration_manager/#{ url_append }")
  end
  
  def self.handle_response(response)
    begin
      parsed_response = JSON.parse(response)
    rescue JSON::ParserError
      raise 'Cradlepointr received an invalid json response.'
    end
    
    return case response.code
           when 200, 302 then parsed_response
           when 400, 401 then false
           when 500 then false
           else false
           end
  end
end