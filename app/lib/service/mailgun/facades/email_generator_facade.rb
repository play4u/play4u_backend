require 'rest_client'

module Service
  module Mailgun
    module Facades
      class EmailGeneratorFacade
        attr_reader :dj, :listener_song_request
        
        
        def initialize(dj,listener_song_request)
          @dj=dj
          @listener_song_request=listener_song_request
        end
        
        # Call RESTful service to generate the email
        def generate_song_request!
          RestClient.get AppConfig::WebSettings.play4u_base_url+
          AppConfig::WebSettings.email_song_request_route+
          '?dj_id='+
          @dj.id+
          '&'+
          'listener_song_request_id='+
          @listener_song_request.id
        end
      end
    end
  end
end