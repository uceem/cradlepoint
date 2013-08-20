module Cradlepoint
  module HashHelpers
    # From 
    # http://devblog.avdi.org/2009/07/14/recursively-symbolize-keys/
    def self.symbolize_keys(hash)
      if hash.is_a?(Array)
        hash.map { |h| symbolize_keys(h) }
      else
        hash.inject({}) { |result, (key, value)|
          new_key = case key
                    when String then key.to_sym
                    else key
                    end
          new_value = case value
                      when Hash then symbolize_keys(value)
                      else value
                      end
          result[new_key] = new_value
          result
        }
      end
    end
  end
end