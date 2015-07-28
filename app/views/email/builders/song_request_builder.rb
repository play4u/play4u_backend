module Views
  module Email
    module Builders
      class SongRequestBuilder
        def set_dj(dj)
          @dj=dj
          self
        end
        
        def set_request(listener_song_request)
          @listener_song_request=listener_song_request
          self
        end
        
        def build
          
        end
      end
    end
  end
end