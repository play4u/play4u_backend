module Service
  module Mailgun
    class EmailSongRequestProxy
      attr_reader :api_adapter, :djs, :listener_song_request
      
      def initialize(djs=[], listener_song_request)
        @djs=djs
        @listener_song_request=listener_song_request
        @api_adapter=::Service::Mailgun::Adapters::ApiAdapter.new
        @email_generator=Service::Mailgun::Builders::EmailGenerator.new
      end
      
      # This will be optimized in the future to be concurrent
      def send!
        return if @djs.blank?
        
        @api_adapter.set_from(AppConfig::ServiceSettings.mailgun_email_address)
        
        djs.each do |dj|
          @api_adapter
          .set_to(dj.email)
          .set_subject(AppConfig::ServiceSettings.song_request_email_subject)
          .set_tag(AppConfig::ServiceSettings.song_request_email_tag)
          .set_body(
            @email_generator
            .set_dj(dj)
            .set_listener_song_request(@listener_song_request)
            .generate_song_request!
          )
          .send!
        end
      end
    end
  end
end