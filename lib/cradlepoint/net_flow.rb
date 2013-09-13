module Cradlepoint
  class NetFlow < CradlepointObject

    attr_accessor :mac, :router, :data, :status_data

    def initialize(mac = nil, router = nil)
      self.mac = mac
      self.router = router
    end

    def self.rel_url
      '/remote'
    end

    def rel_url
      Cradlepoint::NetFlow.rel_url
    end

    def get
      raise 'You must provide a mac' unless self.mac
      return self.data if self.data
      self.data = Cradlepoint.make_request(:get, build_new_url(rel_url), params)
    end

    def get_status
      raise 'You must provide a mac' unless self.mac
      return self.status_data if self.status_data
      self.status_data = Cradlepoint.make_request(:get, build_new_url("#{ rel_url }/status"), params)
    end

    def get_wan_devices
      raise 'You must provide a mac' unless self.mac
      Cradlepoint.make_request(:get, build_new_url("#{ rel_url }/status/wan/devices"), params)
    end

    def params
      { format: :json, mac: self.mac, limit: 1 }
    end
  end
end
