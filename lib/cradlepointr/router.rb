module Cradlepointr
  class Router < CradlepointObject
    def self.rel_url
      '/routers'
    end

    def self.index
      RestClient.get(build_url(rel_url))
    end
  end
end