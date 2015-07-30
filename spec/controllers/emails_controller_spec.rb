require 'rails_helper'

RSpec.describe EmailsController, type: :controller do
  let(:reservation){FactoryGirl.create(:reservation)}
  let(:dj){FactoryGirl.create(:dj)}
  let(:listener_song_request){FactoryGirl.create(:listener_song_request)}
  render_views

  context 'reservation update email' do
    it 'shall generate an email' do
      get :generate_update_reservation, {reservation_id: reservation.id}
      
      expect(response.body).to be_truthy
      expect(response.body.length).to be > 0
    end
  end
  
  context 'reservation cancel email' do
    it 'shall generate an email' do
      get :generate_cancel_reservation, {reservation_id: reservation.id}
      
      expect(response.body).to be_truthy 
      expect(response.body.length).to be > 0
    end
  end
  
  context 'song approve email' do
    it 'shall generate an email' do
      get :generate_song_approve, {reservation_id: reservation.id}
      
      expect(response.body).to be_truthy 
      expect(response.body.length).to be > 0
    end
  end
  
  context 'song request email' do  
   it 'shall generate an email' do
      get :generate_song_request, 
      {dj_id: dj.id, 
        listener_song_request_id: listener_song_request.id}
      
      expect(response.body).to be_truthy 
      expect(response.body.length).to be > 0
      expect(response.body).to include('Accept')
    end
  end
end
