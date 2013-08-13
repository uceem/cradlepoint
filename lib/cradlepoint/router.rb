module Cradlepoint
  class Router < CradlepointObject

    attr_accessor :id, :data, :ecm_firmware_uri, :ecm_configuration_uri, 
                  :ecm_configuration_manager_uri, :ecm_configuration_manager_data

    def initialize(id = nil)
      self.id = id
    end

    def self.rel_url
      '/routers'
    end

    def rel_url
      Cradlepoint::Router.rel_url
    end

    def self.rel_url_with_id(id)
      "#{ rel_url }/#{ id }/"
    end

    def rel_url_with_id
      Cradlepoint::Router.rel_url_with_id(id)
    end

    def self.rel_url_for_configuration_managers(id)
      "#{ Cradlepoint::Router.rel_url_with_id(id) }/confguration_managers/"
    end

    def rel_url_for_configuration_managers
      Cradlepoint::Router.rel_url_with_id(id)
    end

    def self.index
      Cradlepoint.handle_response RestClient.get(build_url(rel_url))
    end

    def get
      check_for_id_or_raise_error
      self.data = Cradlepoint.handle_response RestClient.get(build_url(rel_url_with_id))
    end

    def apply_new_config(config_settings = {})
      config = Cradlepoint::Config.new(self, config_settings)
      config.create_editor
      config.apply_config_to_editor
      config.remove_editor
    end

    def configuration_manager_data
      check_for_id_or_raise_error
      lazy_load_configuration_manager_data unless self.ecm_configuration_manager_data
      self.ecm_configuration_manager_data
    end

    def firmware_data
      check_for_id_or_raise_error
      Cradlepoint.handle_response RestClient.get(build_url(firmware_uri.split('/api/v1').last)) if firmware_uri
    end

    def firmware_uri
      lazy_load_router_data unless self.ecm_firmware_uri
      self.ecm_firmware_uri
    end

    def configuration_uri
      lazy_load_router_data unless self.ecm_configuration_manager_uri
      lazy_load_configuration_manager_data unless self.ecm_configuration_uri
      self.ecm_configuration_uri
    end

    def lazy_load_router_data
      get  # Grab the data from the api.
      self.ecm_firmware_uri = self.data['data']['actual_firmware']
      self.ecm_configuration_manager_uri = self.data['data']['configuration_manager']
    end

    def lazy_load_configuration_manager_data
      self.ecm_configuration_manager_data = Cradlepoint.handle_response RestClient.get(build_url(rel_url_for_configuration_managers),
                                                                                        content_type: :json,
                                                                                        accept: :json)
    end

    def get_configuration_editor_data
      {
        account: '/api/v1' + Cradlepoint.account.rel_url_with_id,
        baseline: configuration_uri,
        firmware: firmware_uri,
        router: '/api/v1' + rel_url_with_id
      }
    end

    private

      def check_for_id_or_raise_error
        raise 'You must provide an ECM router id' if id.nil?
      end
  end
end
