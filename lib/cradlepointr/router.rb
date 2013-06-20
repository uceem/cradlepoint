module Cradlepointr
  class Router < CradlepointObject

    class << self
      attr_accessor :id
    end

    def self.rel_url
      '/routers'
    end

    def self.rel_url_with_id(id)
      "#{ rel_url }/#{ id }"
    end

    def self.index
      Cradlepointr.handle_response RestClient.get(build_url(rel_url))
    end

    def self.get(id = @id)
      raise 'You must provide an ECM router id' if id.nil?
      Cradlepointr.handle_response RestClient.get(build_url(rel_url_with_id(id)))
    end
  end
end