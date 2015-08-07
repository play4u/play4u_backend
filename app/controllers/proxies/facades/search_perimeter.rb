module Controllers
  module Proxies
    module Facades
      # A search perimeter which includes points on/within the perimeter given a radius
      class SearchPerimeter
        DISTANCE_OF_UNIT_LATITUDE=69.0 # miles
        DISTANCE_OF_UNIT_LONGITUDE=60.0 # miles
        attr_reader :listener, :search_radius
        
        def initialize(listener,search_radius)
          @listener=listener
          @search_radius=search_radius
        end
        
        def to_json
          {left: left, right: right, top: top, bottom: bottom}.to_json
        end
        
        def to_str
          to_json
        end
        
        def left
          @listener.location.longitude-@search_radius/DISTANCE_OF_UNIT_LONGITUDE
        end
        
        def right
          @listener.location.longitude+@search_radius/DISTANCE_OF_UNIT_LONGITUDE
        end
   
        def top
          @listener.location.latitude+@search_radius/DISTANCE_OF_UNIT_LATITUDE
        end
        
        def bottom
          @listener.location.latitude-@search_radius/DISTANCE_OF_UNIT_LATITUDE
        end
      end
    end
  end
end