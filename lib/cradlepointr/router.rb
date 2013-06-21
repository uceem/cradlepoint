module Cradlepointr
  class Router < CradlepointObject

    attr_accessor :id, :account, :data, :ecm_firmware_uri, :ecm_configuration_uri

    def initialize(id = nil)
      self.id = id
    end

    def self.rel_url
      '/routers'
    end

    def rel_url
      Cradlepointr::Router.rel_url
    end

    def self.rel_url_with_id(id)
      "#{ rel_url }/#{ id }/"
    end

    def rel_url_with_id
      Cradlepointr::Router.rel_url_with_id(id)
    end

    def self.index
      Cradlepointr.handle_response RestClient.get(build_url(rel_url))
    end

    def get
      raise 'You must provide an ECM router id' if id.nil?
      self.data = Cradlepointr.handle_response RestClient.get(build_url(rel_url_with_id))
    end

    def apply_new_config(config_settings = {})
      config = Cradlepointr::Config.new(self, config_settings)
      Cradlepointr.handle_response RestClient.post(build_url(config.rel_url),
                                                   get_configuration_editor_data.to_json,
                                                   content_type: :json,
                                                   accept: :json)
    end

    def remove_config_patch(config_id)
      Cradlepointr.handle_response RestClient.delete(build_url(Cradlepointr::Config.rel_url_with_id(config_id)),
                                                     content_type: :json,
                                                     accept: :json)
    end

    def firmware_uri
      self.ecm_firmware_uri ? self.ecm_firmware_uri : lazy_load_router_data
      self.ecm_firmware_uri
    end

    def configuration_uri
      self.ecm_configuration_uri ? self.ecm_configuration_uri : lazy_load_router_data
      self.ecm_configuration_uri
    end

    def lazy_load_router_data
      get  # Grab the data from the api.
      self.ecm_firmware_uri = self.data['data']['actual_firmware']
      self.ecm_configuration_uri = self.data['data']['actual']
    end

    def get_configuration_editor_data
      {
        account: '/api/v1' + account.rel_url_with_id,
        baseline: '',
        firmware: firmware_uri,
        router: '/api/v1' + rel_url_with_id
      }
    end
  end
end