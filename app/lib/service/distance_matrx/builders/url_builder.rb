module Service
  module DistanceMatrix
    module Builders
      class URLBuilder
        def set_position(origin,destinations)
          @origin=origin
          @destinations=destinations        
        end
        
        def build
          raise ArgumentError.new('Origin is required') if @origin.blank?
          raise ArgumentError.new('At least one destination is required') if @destinations.blank?
          
          Config::ServiceSettings.google_distance_matrix_base_url+'/json?'+
          'origin='+@origin+'&'+
          'destinations='+@destinations.join("|")+'&'+
          'language=en'+'&'+
          'units=imperial'
        end
      end
    end
  end
end