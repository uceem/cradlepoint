module Cradlepoint
  class NetDevice < CradlepointObject
    include Cradlepoint::HashHelpers

    attr_accessor :id, :router, :data, :bytes_in, :bytes_out, :carrier, :esn, :imei, :info, 
                  :ip_address, :mac, :mode, :name, :type, :uptime

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
      self.data = Cradlepoint.make_request(:get, build_url(rel_url_from_router))
      assign_attributes_from_data(group: true)
    end

    def assign_attributes_from_data(options = {})
      return unless self.data and self.data.any?
      raw_data = self.data

      if options[:group]
        return unless raw_data.is_a?(Array)

        net_devices = []
        raw_data.each do |nd|
          new_net_device = NetDevice.new(nd[:id], self.id)
          new_net_device.assign_attributes_from_blob(nd)
          net_devices << new_net_device
        end

        net_devices
      else
        assign_attributes_from_blob(raw_data)
      end
    end

    def assign_attributes_from_blob(blob = {})
      return unless blob and blob.any?

      self.bytes_in = blob[:bytes_in]
      self.bytes_out = blob[:bytes_out]
      self.carrier = blob[:carrier]
      self.esn = blob[:esn]
      self.imei = blob[:imei]
      self.info = blob[:info]
      self.ip_address = blob[:ip_address]
      self.mac = blob[:mac]
      self.mode = blob[:mode]
      self.name = blob[:name]
      self.type = blob[:type]
      self.uptime = blob[:uptime]
    end
  end
end
