module Cradlepoint
  class NetDevice < CradlepointObject

    attr_accessor :id, :router, :data

    def initialize(id = nil, router = nil)
      self.id = id
      self.router = router
    end

    def self.rel_url
      '/net_devices'
    end

    def rel_url
      Cradlepoint::NetDevice.rel_url
    end

    def self.rel_url_with_id(id)
      "#{ Cradlepoint::NetDevice.rel_url }/#{ id }"
    end

    def rel_url_with_id
      Cradlepoint::NetDevice.rel_url_with_id(id)
    end

    def self.rel_url_from_router(router_id)
      "/routers/#{ router_id }/net_devices/"
    end

    def rel_url_from_router
      Cradlepoint::NetDevice.rel_url_from_router(router.id)
    end

    def get_all_from_router
      raise 'You must provide an ECM router' if router.nil?
      self.data = Cradlepoint.handle_response RestClient.get(build_url(rel_url_from_router),
                                                              content_type: :json,
                                                              accept: :json)
    end
  end
end
