module Service
  class EmailSongRequestProxy
    attr_reader :djs, :listener_song_request
    
    def initialize(djs=[], listener_song_request)
      @djs=djs
      @listener_song_request=listener_song_request
    end
    
    def send!
      raise 'Not implemented!'
    end
  end
end