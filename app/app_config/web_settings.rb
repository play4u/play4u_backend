module AppConfig
  class WebSettings
    def self.play4u_base_url
      ENV['PLAY4U_BASE_URL']
    end
    
    def self.email_song_approve_route
      '/emails/song/approve'
    end
    
    def self.email_song_request_route
      '/emails/song/request'
    end
    
    def self.email_cancel_reservation_route
      '/email/reservation/cancel'
    end
    
    def self.email_update_reservation_route
      '/email/reservation/update'
    end
  end
end