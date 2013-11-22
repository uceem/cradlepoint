module Cradlepoint
  class Account < CradlepointObject

    attr_accessor :id, :data, :disabled, :expiration, :name

    def initialize(ecm_id = nil)
      self.id = ecm_id
    end

    def self.rel_url
      '/accounts'
    end

    def rel_url
      Cradlepoint::Account.rel_url
    end

    def self.rel_url_with_id
      "#{ rel_url }/#{ id }/"
    end

    def rel_url_with_id
      Cradlepoint::Account.rel_url_with_id(id)
    end

    def update
      self.data = Cradlepoint.make_request(:get, build_url(rel_url_with_id))
    end

    def as_json
      as_hash.to_json
    end

    def as_hash
      {
        id: id,
        name: name,
        disabled: disabled,
        expiration: expiration,
      }
    end

    private

    def assign_attributes_from_data
      return unless data and data.any?

      self.name       = data[:name]
      self.disabled   = data[:disabled]
      self.expiration = data[:expiration]
    end
  end
end
