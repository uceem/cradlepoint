module Cradlepoint
  class Router < CradlepointObject
    include Cradlepoint::HashHelpers

    attr_accessor :id, :data, :ecm_firmware_uri, :ecm_configuration_uri, 
                  :ecm_configuration_manager_uri, :ecm_configuration_manager_data,
                  :mac, :config_status, :description, :full_product_name, :ip_address,
                  :name, :stream_usage_in, :stream_usage_out, :stream_usage_period

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
      Cradlepoint.make_request(:get, build_url(rel_url))
    end

    def get
      check_for_id_or_raise_error
      self.data = Cradlepoint.make_request(:get, build_url(rel_url_with_id))
      assign_attributes_from_data
      self.data
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
      Cradlepoint.make_request(:get, build_url(firmware_uri.split('/api/v1').last))
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
      self.ecm_configuration_manager_data = Cradlepoint.make_request(:get, build_url(rel_url_for_configuration_managers))
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

      def assign_attributes_from_data
        return unless self.data and self.data['data'] and self.data['data'].any?

        raw_data = symbolize_keys(self.data['data'])
        self.mac = raw_data[:mac]
        self.name = raw_data[:name]
        self.ip_address = raw_data[:ip_address]
        self.config_status = raw_data[:config_status]
        self.description = raw_data[:description]
        self.full_product_name = raw_data[:full_product_name]
        self.stream_usage_in = raw_data[:stream_usage_in]
        self.stream_usage_out = raw_data[:stream_usage_out]
        self.stream_usage_period = raw_data[:stream_usage_period]
      end

      def check_for_id_or_raise_error
        raise 'You must provide an ECM router id' if id.nil?
      end
  end
end
