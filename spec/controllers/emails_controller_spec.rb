require 'rails_helper'

RSpec.describe EmailsController, type: :controller do
  context 'song request email' do
    render_views
    
    let(:dj){FactoryGirl.create(:dj)}
    let(:listener_song_request){FactoryGirl.create(:listener_song_request)}
    
    it 'shall generate an email to request a song' do
      get :generate_song_request, 
      {dj_id: dj.id, 
        listener_song_request_id: listener_song_request.id}
      
      expect(response.body).to be_truthy 
      expect(response.body.length).to be > 0
      expect(response.body).to include('Accept')
    end
  end
end
