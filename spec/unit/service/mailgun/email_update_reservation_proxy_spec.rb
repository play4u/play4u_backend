require 'rails_helper'
require 'rest_client'

describe Service::Mailgun::EmailCancelReservationProxy do
  let(:url){"https://api:#{mailgun_api_key}@api.mailgun.net/v3/sandbox1b8446f613694bb1ad99ef704020b255.mailgun.org/messages"}
  let(:mailgun_api_key){'key-2f9d8cec06dd38acf34b8f01d96307ba'} 
  let(:reservation){FactoryGirl.create(:reservation)}
  let(:proxy){Service::Mailgun::EmailReservationUpdateProxy.new(reservation)}
  let(:mailgun_email_address){'mailgun_email@mailgun.com'}
  let(:subject){'reservation updated'}  
  let(:tag){'reservation updated'}
  let(:body){'<html><body>reservation updated</body></html>'}
    
  before do
    allow(AppConfig::ServiceSettings)
    .to receive(:mailgun_base_url)
    .and_return(url)
    
    allow(AppConfig::ServiceSettings)
    .to receive(:mailgun_email_address)
    .and_return(mailgun_email_address)
    
    allow(AppConfig::ServiceSettings)
    .to receive(:update_reservation_email_subject)
    .and_return(subject)
    
    allow(AppConfig::ServiceSettings)
    .to receive(:update_reservation_email_tag)
    .and_return(tag)
    
    allow(proxy.email_generator)
    .to receive(:generate_update_reservation!)
    .and_return(body)
    
    allow(proxy.api_adapter)
    .to receive(:send!)
    .and_return(proxy.api_adapter)
  end
  
  it 'shall update a reservation' do
    expect(proxy.api_adapter).to be_truthy
    expect(proxy.api_adapter).to receive(:send!).once
    expect(proxy.api_adapter).to receive(:set_body).with(body).once
    proxy.send!
  end
end