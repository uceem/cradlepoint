module Cradlepointr
  # In order to apply a configuration to the ECM you can simply call 
  # Cradlepointr::Config.update(router), where the router is currently
  # an ActiveRecord object, this will soon merely require a ruby dictionary
  # instead.
  #
  # When update is called, a few steps must be undergone:
  #   1. We must facilitate a POST to create a configuration_editor with the ECM API.
  #   2. We must then perform a PUT of the configuration data to the configuration_editor.
  #   3. Then we simply DELETE the configuration_editor, the ECM API does the rest.
  class Config < CradlepointObject

    attr_accessor :id, :router, :config_settings, :data

    def initialize(router, config_settings = nil)
      self.router = router
      self.config_settings = config_settings
    end

    def self.rel_url
      '/configuration_editors/'
    end

    def rel_url
      Cradlepointr::Config.rel_url
    end

    def self.rel_url_with_id(id)
      "#{ rel_url }#{ id }/"
    end

    def rel_url_with_id(id)
      Cradlepointr::Config.rel_url_with_id(id)
    end

    def self.rel_url_from_router(router)
      "#{ Cradlepointr::Router.rel_url }/#{ router.id }/configuration_manager/"
    end

    def rel_url_from_router(router)
      Cradlepointr::Config.rel_url_from_router(router)
    end

    def get(router = self.router)
      Cradlepointr.handle_response RestClient.get(build_url(rel_url_with_router(router_id)),
                                                  content_type: :json,
                                                  accept: :json)
    end

    # TODO: Accept a hash rather than AR router.
    def self.update(router)

    end

    def create_config_editor(router)
      Cradlepointr.handle_response RestClient.post(build_url(rel_url))
    end

    def self.apply_config_to_config_editor(router)

    end

    def remove
      Cradlepointr.handle_response RestClient.delete(build_url(rel_url_with_id(self.id)),
                                                     content_type: :json,
                                                     accept: :json)
    end
  end
end