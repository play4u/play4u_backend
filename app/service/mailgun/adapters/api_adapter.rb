require 'multimap'

module Service
  module Mailgun
    module Adapters
      class ApiAdapter
        attr_reader :to, :from, :subject, :body, :tag
        
        def initialize
         @url_builder=::Service::Mailgun::Builders::URLBuilder.new
        end
        
        def set_to(to)
          @to=to
          self
        end
        
        def set_from(from)
          @from=from
          self
        end
        
        def set_subject(subject)
          @subject=subject
          self
        end
        
        def set_body(body)
          @body=body
          self
        end
        
        def set_tag(tag)
          @tag=tag
          self
        end
        
        def send!
          url=@url_builder.build
          raise ArgumentError.new("URL is required") if url.blank?
          raise ArgumentError.new('To is required') if to.blank?
          raise ArgumentError.new('From is required') if from.blank?
          raise ArgumentError.new('Subject is required') if subject.blank?
          raise ArgumentError.new('Body is required') if body.blank?
          
          data=Multimap.new         
          data[:to]=to 
          data[:from]=from
          data[:subject]=subject
          data[:body]=body
          data[:tag]=tag
          
          @json_response_hash=JSON.parse(RestClient.get url, data)
          
          @logger.info %Q(Sent URL: #{url}
            Response: #{@json_response_hash}
          )
          
          self
        end
      end
    end
  end
end