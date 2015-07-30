module AppConfig
  class ViewSettings
    DEFAULT_ROW_LIMIT=5
    
    def self.reservations_row_limit
      ENV['DISPLAY_RESERVATIONS_ROW_LIMIT'] || DEFAULT_ROW_LIMIT
    end
  end
end