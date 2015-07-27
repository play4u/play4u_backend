module Config
  # Retrieve service setting
  class ServiceSettings
    def self.google_api_key
      ENV['GOOGLE_API_KEY']
    end
    
    def self.google_distance_matrix_base_url
      ENV['GOOGLE_DISTANCE_MATRIX_BASE_URL']
    end
  end
end