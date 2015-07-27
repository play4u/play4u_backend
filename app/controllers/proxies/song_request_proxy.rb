require 'position'
require 'email_song_request_proxy'
require 'log4r'
require 'rest_client'

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
      Service::Mail::EmailSongRequestProxy.new(@djs_found,@request).send!
      @request
    end
  end
end