module Cradlepointr
  class Router < CradlepointObject

    attr_accessor :id, :data, :ecm_firmware_id

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
      "#{ rel_url }/#{ id }"
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

    def firmware_id
      self.ecm_firmware_id ? self.firmware_id : lazy_load_router_data
    end

    def lazy_load_router_data
      get  # Grab the data from the api.
      self.ecm_firmware_id = self.data['data']['actual_firmware'].split('/').last
    end

    def get_configuration_editor_data
      {
        account: account.rel_url_with_id,
        baseline: '',
        firmware: '',
        router: rel_url_with_id
      }
    end
  end
end