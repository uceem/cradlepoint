module Cradlepointr
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
      Cradlepointr::NetFlow.rel_url
    end

    def get
      raise 'You must provide a mac' unless self.mac
      self.data = Cradlepointr.handle_response RestClient.get(build_new_url(rel_url), params)
    end

    def get_status
      raise 'You must provide a mac' unless self.mac
      self.status_data = Cradlepointr.handle_response RestClient.get(build_new_url("#{ rel_url }/status"), params)
    end

    def params
      { params: { format: :json, mac: self.mac, limit: 1 }, accept: :json, content_type: :json }
    end
  end
end