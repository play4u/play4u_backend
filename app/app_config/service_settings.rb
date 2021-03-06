module AppConfig
  # Retrieve service setting
  class ServiceSettings
    def self.google_api_key
      ENV['GOOGLE_API_KEY']
    end
    
    def self.google_distance_matrix_base_url
      ENV['GOOGLE_DISTANCE_MATRIX_BASE_URL']
    end
    
    def self.mailgun_base_url
      ENV['MAILGUN_BASE_URL']
    end
    
    def self.mailgun_email_address
      ENV['MAILGUN_EMAIL_ADDRESS']
    end
    
    def self.mailgun_email_display_name
      ENV['MAILGUN_EMAIL_DISPLAY_NAME']
    end
    
    def self.song_request_email_subject
      ENV['SONG_REQUEST_EMAIL_SUBJECT']
    end
    
    def self.song_approve_email_subject
      ENV['SONG_APPROVE_EMAIL_SUBJECT']
    end
    
    def self.song_request_email_tag
      ENV['SONG_REQUEST_EMAIL_TAG']
    end
    
    def self.song_approve_email_tag
      ENV['SONG_APPROVE_EMAIL_TAG']
    end
    
    def self.cancel_reservation_email_tag
      ENV['CANCEL_RESERVATION_EMAIL_TAG']
    end
    
    def self.cancel_reservation_email_subject
      ENV['CANCEL_RESERVATION_EMAIL_SUBJECT']
    end
    
    def self.update_reservation_email_tag
      ENV['UPDATE_RESERVATION_EMAIL_TAG']
    end
    
    def self.update_reservation_email_subject
      ENV['UPDATE_RESERVATION_EMAIL_SUBJECT']
    end
  end
end