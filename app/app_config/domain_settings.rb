module AppConfig
  class DomainSettings
    def self.search_radius
      ENV['SEARCH_RADIUS'].to_f
    end
  end
end