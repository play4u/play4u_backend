module Util
  class Position
    attr_reader :longitude,:latitude
    
    def initialize(latitude, longitude)
      @longitude=longitude
      @latitude=latitude
      
      raise ArgumentError.new('Longitude is required') if @longitude.blank?
      raise ArgumentError.new('Latitude is required') if @latitude.blank?
    end
    
    def to_s
      "#{latitude},#{longitude}"
    end
  end
end