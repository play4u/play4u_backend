module Util
  class Position
    attr_reader :longitude,:latitude
    
    def initialize(latitude, longitude)
      @longitude=longitude
      @latitude=latitude
    end
    
    def to_s
      latitude+","+longitude
    end
  end
end