module Cradlepointr
  # In order to apply a configuration to the ECM you can simply call 
  # Cradlepointr::Config.update(router), where the router is currently
  # an ActiveRecord object, this will soon merely require a ruby dictionary
  # instead.
  #
  # When update is called, a few steps must be undergone:
  #   1. We must facilitate a POST to create a configuration_editor with the ECM API.
  #   2. We must then perform a PUT of the configuration data to the configuration_editor.
  #   3. Then we simply DELETE the configuration_editor, the ECM API does the rest.
  class Config < CradlepointObject

    attr_accessor :id, :router, :config_settings, :config_editor_id, :data

    def initialize(router, config_settings = nil)
      self.router = router
      self.config_settings = config_settings
    end

    def self.rel_url
      '/configuration_editors/'
    end

    def rel_url
      Cradlepointr::Config.rel_url
    end

    def self.rel_url_with_id(id)
      "#{ rel_url }#{ id }/"
    end

    def rel_url_with_id
      Cradlepointr::Config.rel_url_with_id(id)
    end

    def self.rel_url_from_router(router)
      "#{ Cradlepointr::Router.rel_url }/#{ router.id }/configuration_manager/"
    end

    def rel_url_from_router
      Cradlepointr::Config.rel_url_from_router(router)
    end

    def create_editor
      self.data = Cradlepointr.handle_response RestClient.post(build_url(rel_url),
                                                               router.get_configuration_editor_data.to_json,
                                                               content_type: :json,
                                                               accept: :json)
      self.id = self.data['data']['id']
      self.data
    end

    def apply_config_to_editor
      self.data = Cradlepointr.handle_response RestClient.put(build_url(rel_url_with_id),
                                                              get_config_data_with_wrapper(config_settings).to_json,
                                                              content_type: :json,
                                                              accept: :json)
    end

    def remove_editor
      self.data = Cradlepointr.handle_response RestClient.delete(build_url(rel_url_with_id),
                                                                 content_type: :json,
                                                                 accept: :json)
    end

    private

      def get_config_data_with_wrapper(config_settings = {})
        editor_data = router.get_configuration_editor_data
        editor_data[:resource_uri] = '/api/v1' + rel_url_with_id
        editor_data[:committed] = true
        editor_data[:id] = self.id
        editor_data[:diff_from_default] = [wifi_values_wrapper(config_settings), []]
        editor_data
      end
      
      def wifi_values_wrapper(config_settings)
        {
          wlan: {
            bss: {
              :'0' => wifi_values(config_settings)
            }
          }
        }
      end
      
      def wifi_values(config_settings)
        {
          system: { ui_activated: true },
          radius0ip: config_settings[:radius_ip1],
          radius1ip: config_settings[:radius_ip2],
          radius0key: config_settings[:shared_secret] || :foobarbaz,
          ssid: config_settings[:ssid] || '@uceem_ECM'
        }
      end
  end
end