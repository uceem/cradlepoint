module Cradlepointr
  class NetDevice < CradlepointObject

    class << self
      attr_accessor :router_id
    end

    def self.rel_url(router_id)
      "/routers/#{ router_id }/net_devices/"
    end

    def self.get(router_id = @router_id)
      raise 'You must provide an ECM router id' if @router_id.nil?
      Cradlepointr.handle_response RestClient.get(build_url(rel_url(router_id)),
                                                  content_type: :json,
                                                  accept: :json)
    end
  end
end