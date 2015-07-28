require 'rest_client'
require 'json'
require 'log4r'

module Service
  module DistanceMatrix
    module Adapters
      class ApiAdapter
        attr_reader :json_hash
        
        def initialize
          @url_builder=Service::DistanceMatrix::Builders::URLBuilder.new
          @logger=Log4r::Logger['model']
        end
        
        def set_origin(origin)
          @url_builder.set_origin(origin)
          self
        end
        
        def set_destination(destination)
          @url_builder.set_destination(destination)
          self
        end
        
        def send!
          url=@url_builder.build
          raise ArgumentError.new("URL is missing") if url.blank?
          @json_response_hash=JSON.parse(RestClient.get(url))
          
          @logger.info %Q(Sent URL: #{url}
            Response: #{@json_response_hash}
          )
          self
        end
        
        # Retrieves the distance as a float, rounded to the nearest whole number
        # Returns nil if distance was not found
        def get_distance
          return nil if @json_response_hash.blank? || 
          @json_response_hash['rows'].blank?
          
          @json_response_hash['rows']
          .first['elements']
          .first['distance']['text']
          .to_f
          .round
        end
      end
    end
  end
end