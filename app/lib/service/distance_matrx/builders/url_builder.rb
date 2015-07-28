module Service
  module DistanceMatrix
    module Builders
      class URLBuilder
        attr_reader :origin, :destination
        
        def set_destination(destination)
          @destination = destination
          self        
        end
        
        def set_origin(origin)
          @origin=origin
          self
        end
        
        def build
          raise ArgumentError.new('Origin is required') if @origin.blank?
          raise ArgumentError.new('Destination is required') if @destination.blank?
          
          AppConfig::ServiceSettings.google_distance_matrix_base_url+'/json?'+
          'origin=' + @origin.to_s + '&' +
          'destinations=' + @destination.to_s + '&' +
          'language=en'+ '&' +
          'units=imperial' + '&' +
          'key=' + AppConfig::ServiceSettings.google_api_key
        end
      end
    end
  end
end