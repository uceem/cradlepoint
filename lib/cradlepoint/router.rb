module Cradlepoint
  class Router < CradlepointObject

    attr_accessor :id, :data, :ecm_firmware_uri, :ecm_configuration_uri, 
                  :ecm_configuration_manager_uri, :ecm_configuration_manager_data,
                  :mac, :config_status, :description, :full_product_name, :ip_address,
                  :name, :stream_usage_in, :stream_usage_out, :stream_usage_period

    def initialize(id = nil, options = {})
      self.id = id
      options.each { |k, v| send("#{ k }=", v) if v }
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
      build_array_of_routers_from_response(Cradlepoint.make_request(:get, build_url(rel_url)))
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
      Cradlepoint.make_request(:get, build_url(firmware_uri.split('/api/v1').last)) if firmware_uri
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
      self.ecm_firmware_uri = self.data[:actual_firmware]
      self.ecm_configuration_manager_uri = self.data[:configuration_manager]
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

    def assign_attributes_from_data
      return unless self.data and self.data.any?

      self.mac = self.data[:mac]
      self.name = self.data[:name]
      self.ip_address = self.data[:ip_address]
      self.config_status = self.data[:config_status]
      self.description = self.data[:description]
      self.full_product_name = self.data[:full_product_name]
      self.stream_usage_in = self.data[:stream_usage_in]
      self.stream_usage_out = self.data[:stream_usage_out]
      self.stream_usage_period = self.data[:stream_usage_period]
    end

    private

      def self.build_array_of_routers_from_response(response)
        return false unless successful_response?(response)
        response.map { |r| create_and_assign_attributes_from_data(r) }
      end

      def self.create_and_assign_attributes_from_data(data)
        return unless ecm_object_blob?(data)
        router = Cradlepoint::Router.new(data[:id], data: data)
        router.assign_attributes_from_data
        router
      end

      def check_for_id_or_raise_error
        raise 'You must provide an ECM router id' if id.nil?
      end
  end
end
