module Cradlepointr
  class CradlepointObject
    def self.build_url(rel_url = '/')
      "#{ Uceem.url_prepend }#{ Uceem.base_url }#{ rel_url }#{ Uceem.url_append }"
    end
  end
end