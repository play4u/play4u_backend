module AppConfig
  class ViewSettings
    DEFAULT_EVENTS_ROW_LIMIT=5
    
    def self.events_row_limit
      ENV['DISPLAY_EVENTS_ROW_LIMIT'] || DEFAULT_EVENTS_ROW_LIMIT
    end
  end
end