require 'log4r'
require 'rest_client'

module Controllers
  module Proxies
    # Interface for a listener to request a song
    # Listener: a Listener object
    # Song: a Song object
    # Position: a Position object
    class SongRequestProxy
      attr_reader :listener, :song, :search_perimeter
      
      def initialize(listener, song)
        @search_radius=AppConfig::DomainSettings.search_radius # miles
        @listener=listener
        
        @search_perimeter=Controllers::Proxies::Facades::SearchPerimeter
        .new(@listener,@search_radius)
        
        @song=song
        @logger = Log4r::Logger['model']
      end
      
      # Request a song from multiple MJs
      # Returns the request
      def request!
        @request=ListenerSongRequest.create!(listener: @listener, song: @song, 
        longitude: @listener.location.longitude, latitude: @listener.location.latitude)
        
        @logger.info('Created request: '+@request.to_json)
        
        # Record the attempted song requests for each MJ
        # TODO: Will optimize in the future to use concurrency
        MusicJockey
        .joins(:location)
        .where(Location.arel_table[:latitude].gteq(@search_perimeter.bottom))
        .where(Location.arel_table[:latitude].lteq(@search_perimeter.top))
        .where(Location.arel_table[:longitude].gteq(@search_perimeter.left))
        .where(Location.arel_table[:longitude].lteq(@search_perimeter.right)) 
        .find_each do |mj|
          MusicJockeySongRequest.create!(music_jockey_id: mj.id, listener_song_request_id: @request.id)
        end
      end
    end
  end
end