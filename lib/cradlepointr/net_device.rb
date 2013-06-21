module Cradlepointr
  class NetDevice < CradlepointObject

    attr_accessor :id, :router_id

    def initialize(id = nil, router_id = nil)
      self.id = id
      self.router_id = router_id
    end

    def self.rel_url
      '/net_devices'
    end

    def rel_url
      Cradlepointr::NetDevice.rel_url
    end

    def self.rel_url_with_id(id)
      "#{ Cradlepointr::NetDevice.rel_url }/#{ id }"
    end

    def rel_url_with_id(id = self.id)
      Cradlepointr::NetDevice.rel_url_with_id(id)
    end

    def self.rel_url_from_router(router_id)
      "/routers/#{ router_id }/net_devices/"
    end

    def rel_url_from_router(router_id = self.router_id)
      Cradlepointr::NetDevice.rel_url_from_router(router_id)
    end

    def get_all_from_router(router_id = self.router_id)
      raise 'You must provide an ECM router id' if router_id.nil?
      Cradlepointr.handle_response RestClient.get(build_url(rel_url_from_router(router_id)),
                                                  content_type: :json,
                                                  accept: :json)
    end
  end
end