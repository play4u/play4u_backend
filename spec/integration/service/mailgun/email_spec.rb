require 'rails_helper'
require 'rest_client'
require 'json'

describe 'mailgun integration' do
  context 'send email' do
    let(:url){'https://api:key-2f9d8cec06dd38acf34b8f01d96307ba@api.mailgun.net/v3/sandbox1b8446f613694bb1ad99ef704020b255.mailgun.org/messages'}
    
    it 'shall send' do
      response=RestClient.post url,
      :from => "Excited User <mailgun@sandbox1b8446f613694bb1ad99ef704020b255.mailgun.org>",
      :to => "tangeroknight@gmail.com",
      :subject => "Hello",
      :text => "Testing some Mailgun awesomness!"
  
      json_hash=JSON.parse(response)
      expect(json_hash).to have_key('message')
    end  
  end
end
