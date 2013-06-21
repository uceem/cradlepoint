module Cradlepointr
  class CradlepointObject

    def self.build_url(rel_url = '/')
      "#{ Cradlepointr.url_prepend }#{ Cradlepointr.base_url }#{ rel_url }#{ Cradlepointr.url_append }"
    end

    def build_url(rel_url = '/')
      CradlepointObject.build_url(rel_url)
    end
  end
end