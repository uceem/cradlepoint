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
    def self.rel_url
      '/configuration_editors'
    end

    def self.rel_url_with_id(id)
      "#{ rel_url }/#{ id }/"
    end

    def self.rel_url_with_router(router_id)
      "#{ Cradlepointr::Router.rel_url }/#{ router_id }/configuration_manager/"
    end

    def self.get(router_id)
      Cradlepointr.handle_response RestClient.get(build_url(rel_url_with_router(router_id)),
                                                  content_type: :json,
                                                  accept: :json)
    end

    # TODO: Accept a hash rather than AR router.
    def self.update(router)

    end

    def self.create_config_editor(router)

    end

    def self.apply_config_to_config_editor(router)

    end

    def remove_config_editor(id)
      Cradlepointr.handle_response RestClient.delete(build_url(rel_url_with_id(id),
                                                     content_type: :json,
                                                     accept: :json)
    end
  end
end