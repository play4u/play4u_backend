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
  end
  
  it 'shall request a song' do
    
  end
end