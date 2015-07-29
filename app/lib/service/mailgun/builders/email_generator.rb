require 'rest_client'

module Service
  module Mailgun
    module Builders
      class EmailGenerator
        attr_reader :dj, :listener_song_request
        
        def set_listener_song_request(lsr)
          @listener_song_request=lsr
        end
        
        def set_dj(dj)
          @dj=dj
        end
        
        # Call RESTful service to generate the email
        def generate_song_request!
          raise ArgumentError.new('DJ is required') if @dj.blank?
          raise ArgumentError.new('Listener song request is required') if @listener_song_request.blank?
          
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