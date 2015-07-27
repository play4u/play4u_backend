require 'rest_client'
require 'json'

module Service
  module DistanceMatrix
    class LocateDJProxy
      SEARCH_RADIUS=5
      
      def initialize(listener,search_radius=SEARCH_RADIUS)
        @listener=listener
        @search_radius=search_radius
      end
      
      # Finds all DJs
      # In the future, this will be optimized to use map/reduce concurrently
      # and probably will use Redis to cache the DJs found
      # Returns a list of DJs within a specified radius
      def locate!
        djs_found=[]
        listener_position=Util::Position.new(@listener.latitude,@listener.longitude)
        
        DJ.all.for_each do |dj|
          dj_position=Util::Position.new(dj.location.latitude, dj.location.longitude)
          
          response=RestClient.get(Service::DistanceMatrix::Builders::URLBuilder.new(
          listener_position,[dj_position]).build)
    
          hash_json=JSON.parse(response.to_s)
          
          if hash_json['rows'].present? && hash_json['rows'].
            first['elements'].first['distance']['text'].to_f <= @search_radius
            djs_found << dj
          end
        end
        
        djs_found
      end
    end
  end
end