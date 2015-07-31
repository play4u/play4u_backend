require 'rest_client'

module Service
  module Mailgun
    module Builders
      class EmailGenerator
        attr_reader :dj, :listener_song_request, :reservation
        
        def set_reservation(reservation)
          @reservation=reservation
          self
        end
        
        def set_listener_song_request(lsr)
          @listener_song_request=lsr
          self
        end
        
        def set_dj(dj)
          @dj=dj
          self
        end
        
        def generate_update_reservation!
          raise ArgumentError.new('Reservation is required') if @reservation.blank?
          
          url=AppConfig::WebSettings.play4u_base_url+
          "#{AppConfig::WebSettings.email_update_reservation_route}?"+
          "reservation_id=#{@reservation.id}"
          
          RestClient.get url
        end
        
        def generate_cancel_reservation!
          raise ArgumentError.new('Reservation is required') if @reservation.blank?
          
          url=AppConfig::WebSettings.play4u_base_url+
          "#{AppConfig::WebSettings.email_cancel_reservation_route}?"+
          "reservation_id=#{@reservation.id}"
          
          RestClient.get url  
        end
        
        def generate_song_approval!
          raise ArgumentError.new('Reservation is required') if @reservation.blank?
          
          url = AppConfig::WebSettings.play4u_base_url+
          "#{AppConfig::WebSettings.email_song_approve_route}?"+
          "reservation_id=#{@reservation.id}"
           
          RestClient.get url
        end
        
        # Call RESTful service to generate the email
        def generate_song_request!
          raise ArgumentError.new('DJ is required') if @dj.blank?
          raise ArgumentError.new('Listener song request is required') if @listener_song_request.blank?
          
          url=AppConfig::WebSettings.play4u_base_url+
          "#{AppConfig::WebSettings.email_song_request_route}?"+
          "dj_id=#{@dj.id}&"+
          "listener_song_request_id=#{@listener_song_request.id}"
          
          RestClient.get url
        end
      end
    end
  end
end