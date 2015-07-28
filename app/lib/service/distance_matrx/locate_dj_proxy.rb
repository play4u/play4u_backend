require 'log4r'
require 'rest_client'
require 'json'

module Service
  module DistanceMatrix
    class LocateDJProxy
      SEARCH_RADIUS=5
      
      attr_reader :search_radius, :api_adapter, :listener
      
      def initialize(listener,search_radius=SEARCH_RADIUS)
        @listener=listener
        @search_radius=search_radius
        @logger=Log4r::Logger['model']
        @api_adapter=::Service::DistanceMatrix::Adapters::ApiAdapter.new
      end
      
      # Finds all DJs
      # In the future, this will be optimized to use map/reduce concurrently
      # and probably will use Redis to cache the DJs found
      # Returns a list of DJs within a specified radius
      def locate!
        djs_found=[]
        
        Dj.find_each do |dj|
          distance=@api_adapter
          .set_origin(@listener.location.get_position)
          .set_destination(dj.location.get_position)
          .send!
          .get_distance
          
          if distance <= @search_radius
            djs_found << dj
          else
             @logger.warn %Q(Distance NOT found 
             Listener id: #{@listener.id} 
             DJ id: #{dj.id} 
             Origin: #{@listener.location.get_position}
             Destination: #{dj.location.get_position}
             )
          end
        end
        
        djs_found
      end
    end
  end
end