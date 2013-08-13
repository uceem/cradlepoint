module Cradlepoint
  class CradlepointObject

    def self.build_url(rel_url = '/')
      "#{ Cradlepoint.url_prepend }#{ Cradlepoint.base_url }#{ rel_url }#{ Cradlepoint.url_append }"
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
  end
end
