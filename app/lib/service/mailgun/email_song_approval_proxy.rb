module Service
  module Mailgun
    class EmailSongApprovalProxy
      attr_reader :dj, :listener_song_request, :api_adapter, :email_generator
      
      def initialize(dj, listener_song_request)
        @dj=dj
        @listener_song_request=listener_song_request
        @api_adapter=::Service::Mailgun::Adapters::ApiAdapter.new
        @email_generator=Service::Mailgun::Builders::EmailGenerator.new
      end
      
      def send!
        
      end
    end
  end
end