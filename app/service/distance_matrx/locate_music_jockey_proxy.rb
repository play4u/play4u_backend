require 'log4r'
require 'rest_client'
require 'json'

module Service
  module DistanceMatrix
    class LocateMusicJockeyProxy
      SEARCH_RADIUS=5
      
      attr_reader :search_radius, :api_adapter, :listener
      
      def initialize(listener,search_radius=SEARCH_RADIUS)
        @listener=listener
        @search_radius=search_radius
        @logger=Log4r::Logger['model']
        @api_adapter=::Service::DistanceMatrix::Adapters::ApiAdapter.new
      end
      
      # Finds all DJs
      # TODO: optimize to use map/reduce concurrently
      # and probably will use Redis to cache the DJs found
      # Returns a list of DJs within a specified radius
      def locate!
        mjs_found=[]
        
        MusicJockey.find_each do |mj|
          distance=@api_adapter
          .set_origin(@listener.location.get_position)
          .set_destination(mj.location.get_position)
          .send!
          .get_distance
          
          if distance <= @search_radius
            mjs_found << mj
          else
             @logger.warn %Q(Distance NOT found 
             Listener id: #{@listener.id} 
             Music jockey id: #{mj.id} 
             Origin: #{@listener.location.get_position}
             Destination: #{mj.location.get_position}
             )
          end
        end
        
        mjs_found
      end
    end
  end
end