module Cradlepoint
  class Account < CradlepointObject

    attr_accessor :ecm_id, :data, :disabled, :expiration, :name

    def initialize(id = nil)
      self.ecm_id = id
    end

    def self.rel_url
      '/accounts'
    end

    def rel_url
      Cradlepoint::Account.rel_url
    end

    def self.rel_url_with_id(id)
      "#{ rel_url }/#{ id }/"
    end

    def rel_url_with_id
      Cradlepoint::Account.rel_url_with_id(id)
    end

    def id
      self.ecm_id ? self.ecm_id : lazy_load_id
    end

    def lazy_load_id
      self.data = Cradlepoint.make_request(:get, build_url(rel_url))
      self.ecm_id = self.data[0][:id]
      self.ecm_id
    end
  end
end
