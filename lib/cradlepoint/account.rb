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

    def to_json
      {
        id: id,
        name: name,
        disabled: disabled,
        expiration: expiration,
      }.to_json
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
