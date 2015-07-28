module AppConfig
  # Retrieve service setting
  class ServiceSettings
    def self.google_api_key
      ENV['GOOGLE_API_KEY']
    end
    
    def self.google_distance_matrix_base_url
      ENV['GOOGLE_DISTANCE_MATRIX_BASE_URL']
    end
    
    def self.mailgun_api_key
      ENV['MAILGUN_API_KEY']
    end
    
    def self.mailgun_base_url
      ENV['MAILGUN_BASE_URL']
    end
  end
end