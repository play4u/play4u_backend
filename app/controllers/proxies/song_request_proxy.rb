require 'log4r'
require 'rest_client'

module Controllers
  module Proxy
    # Interface for a listener to request a song
    # Listener: a Listener object
    # Song: a Song object
    # Position: a Position object
    class SongRequestProxy
      attr_reader :listener, :song, :position
      
      def initialize(listener, song, position)
        @listener=listener
        @song=song
        @position=position
        @logger = Log4r::Logger['model']
      end
      
      # Request a song from multiple DJs
      # Returns the request
      def request!
        @request=ListenerSongRequest.create(listener: @listener, song: @song, 
        longitude: @position.longitude, latitude: @position.latitude)
        
        @logger.info('Created request: '+@request.to_json)
        @djs_found = Service::DistanceMatrix::LocateDJProxy.new(@listener).locate!
        
        # Record the attempted song requests for each DJ
        # TODO: Will optimize in the future to use concurrency
        @djs_found.each do |dj|
          DjSongRequest.create(dj_id: dj.id, listener_song_request_id: @request.id)
        end
        
        # TODO: use concurrency
        Service::Mailgun::EmailSongRequestProxy.new(@djs_found,@request).send!
        @request
      end
    end
  end
end