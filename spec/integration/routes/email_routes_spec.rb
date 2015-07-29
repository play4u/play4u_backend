require 'rails_helper'

describe 'email routes' do
  it 'shall route a song request email' do
    assert_generates AppConfig::WebSettings.email_song_request_route, 
    { controller: 'emails', action: 'generate_song_request'}
  end
end
