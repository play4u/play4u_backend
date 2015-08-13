require 'log4r'
require 'rest_client'


module Proxies
  # Interface for a listener to request a song
  # Listener: a Listener object
  # Song: a Song object
  # Position: a Position object
  class SongRequestProxy
    attr_reader :listener, :song, :search_perimeter
    
    def initialize(listener,song,search_radius)
      @search_radius=search_radius
      @listener=listener
      
      @search_perimeter=::Proxies::Facades::SearchPerimeter
      .new(@listener,@search_radius)
      
      @song=song
      @logger = Log4r::Logger['model']
    end
    
    # Request a song from multiple MJs
    # Returns the request
    def request! 
      @request=ListenerSongRequest.new
      @request.listener=@listener
      @request.song=@song
      @request.longitude=@listener.location.longitude
      @request.latitude=@listener.location.latitude
      @request.save!
      @logger.info('Created request: '+@request.to_json)
      
      AppConfig::Scalability::THREAD_POOL.process{
        MusicJockey
        .joins(:location)
        .where(Location.arel_table[:latitude].gteq(@search_perimeter.bottom))
        .where(Location.arel_table[:latitude].lteq(@search_perimeter.top))
        .where(Location.arel_table[:longitude].gteq(@search_perimeter.left))
        .where(Location.arel_table[:longitude].lteq(@search_perimeter.right)) 
        .find_each do |mj|
          AppConfig::Scalability::THREAD_POOL.process {
            MusicJockeySongRequest.create!(music_jockey_id: mj.id, listener_song_request_id: @request.id)
          }
        end
      }
    end
  end
end