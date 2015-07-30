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
        body=@email_generator.generate_song_approval!
        
        @api_adapter
        .set_to(@listener_song_request.listener.email)
        .set_from(AppConfig::ServiceSettings.mailgun_email_address)
        .set_tag(AppConfig::ServiceSettings.song_approve_email_tag)
        .set_subject(AppConfig::ServiceSettings.song_approve_email_subject)
        .set_body(body)
        .send!
      end
    end
  end
end