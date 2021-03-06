module Service
  module Mailgun
    class EmailReservationUpdateProxy
      attr_reader :reservation, :api_adapter, :email_generator
      
      def initialize(reservation)
        @reservation=reservation
        @api_adapter=::Service::Mailgun::Adapters::ApiAdapter.new
        @email_generator=Service::Mailgun::Builders::EmailGenerator.new
      end
      
      def send!
        body=@email_generator
        .set_reservation(@reservation)
        .generate_update_reservation!
        
        @api_adapter
        .set_to(@reservation.listener.email)
        .set_from(AppConfig::ServiceSettings.mailgun_email_address)
        .set_tag(AppConfig::ServiceSettings.update_reservation_email_tag)
        .set_subject(AppConfig::ServiceSettings.update_reservation_email_subject)
        .set_body(body)
        
        @api_adapter.send!
      end
    end
  end
end