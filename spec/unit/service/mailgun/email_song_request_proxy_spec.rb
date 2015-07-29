require 'rails_helper'
require 'rest_client'

describe Service::Mailgun::EmailSongRequestProxy do
  let(:url){"https://api:#{mailgun_api_key}@api.mailgun.net/v3/sandbox1b8446f613694bb1ad99ef704020b255.mailgun.org/messages"}
  let(:mailgun_api_key){'key-2f9d8cec06dd38acf34b8f01d96307ba'} 
  let(:dj){FactoryGirl.create(:dj)}
  let(:listener_song_request){FactoryGirl.create(:listener_song_request)}
  let(:proxy){Service::Mailgun::EmailSongRequestProxy.new([dj],listener_song_request)} 
  let(:mailgun_email_address){'mailgun_email@mailgun.com'}
  let(:subject){'song requested'}  
  let(:tag){'song_request'}
  let(:song_request_email_body){'<html><body>song request</body></html>'}
    
  before do
    allow(AppConfig::ServiceSettings)
    .to receive(:mailgun_base_url)
    .and_return(url)
    
    allow(AppConfig::ServiceSettings)
    .to receive(:mailgun_email_address)
    .and_return(mailgun_email_address)
    
    allow(AppConfig::ServiceSettings)
    .to receive(:song_request_email_subject)
    .and_return(subject)
    
    allow(AppConfig::ServiceSettings)
    .to receive(:song_request_email_tag)
    .and_return(tag)
    
    allow(proxy.email_generator)
    .to receive(:generate_song_request!)
    .and_return(song_request_email_body)
    
    allow(proxy.api_adapter)
    .to receive(:send!)
    .and_return(proxy.api_adapter)
  end
  
  it 'shall request a song' do
    expect(proxy.djs.length).to eq(1)
    expect(proxy.api_adapter).to be_truthy
    expect(proxy.api_adapter).to receive(:send!).once
    expect(proxy.api_adapter).to receive(:set_body).with(song_request_email_body).once
    proxy.send!
  end
end