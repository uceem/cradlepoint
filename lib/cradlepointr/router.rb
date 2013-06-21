module Cradlepointr
  class Router < CradlepointObject

    attr_accessor :id, :data, :configuration_uri

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

    def rel_url_with_id(id)
      Cradlepointr::Router.rel_url_with_id(id)
    end

    def self.index
      Cradlepointr.handle_response RestClient.get(build_url(rel_url))
    end

    def get
      raise 'You must provide an ECM router id' if id.nil?
      self.data = Cradlepointr.handle_response RestClient.get(build_url(rel_url_with_id(id)))
    end

    def load_config_patch_data
      return true if self.configuration_id and self.firmware_id
      data = Cradlepointr.handle_response RestClient.get(build_url("#{ rel_url_with_id(self.id) }/configuration_manager"))
    end
  end
end