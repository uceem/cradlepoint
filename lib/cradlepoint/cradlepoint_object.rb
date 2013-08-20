module Cradlepoint
  class CradlepointObject

    def self.build_url(rel_url = '/')
      "#{ Cradlepoint.url_prepend }#{ Cradlepoint.base_url }#{ rel_url }"
    end

    def build_url(rel_url = '/')
      CradlepointObject.build_url(rel_url)
    end

    def self.build_new_url(rel_url = '/')
      "#{ Cradlepoint.url_prepend }#{ Cradlepoint.base_url }#{ rel_url }"
    end

    def build_new_url(rel_url = '/')
      CradlepointObject.build_new_url(rel_url)
    end

    def params
      { params: { format: :json } }
    end

    def self.successful_response?(response)
      return false unless response
      return false if response.is_a?(Hash) and !response[:success]
      true
    end

    def successful_response?(response)
      Cradlepoint::CradlepointObject.successful_response?(response)
    end

    def self.ecm_object_blob?(object_blob)
      return false unless object_blob
      return false unless object_blob.is_a?(Hash) and object_blob[:id]
      true
    end

    def ecm_object_blob?(object_blob)
      Cradlepoint::CradlepointObject.ecm_object_blob?(object_blob)
    end
  end
end
