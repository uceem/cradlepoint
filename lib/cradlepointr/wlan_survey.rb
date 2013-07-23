module Cradlepointr
  class WlanSurvey < CradlepointObject

    attr_accessor :router, :data

    def initialize(router = nil)
      self.router = router
    end

    def self.rel_url
      '/remote/status/wlan/survey'
    end

    def self.get
      # ...
    end
  end
end