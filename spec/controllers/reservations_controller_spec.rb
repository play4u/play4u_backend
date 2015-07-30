require 'rails_helper'
require 'rest_client'

describe ReservationsController, type: :controller do
  render_views
  let(:reservation){FactoryGirl.create(:reservation)}
  let(:dj){reservation.dj}
  let(:listener){reservation.listener}
  
  before do
    allow(RestClient).to receive(:get).and_return('')
  end
  
  context 'cancel reservation' do
    it 'shall cancel a reservation' do
      delete 'destroy', {id: reservation.id, dj_id: reservation.dj.id}
      assert_response :success
      expect(Reservation.exists?(reservation.id)).to be false
    end
  end
  
  context 'update reservation' do
    before do
      reservation.place_id=10
      reservation.save!
    end
    
    it 'shall update a reservation' do
      put 'update', {id: reservation.id, dj_id: reservation.dj.id, place_id: 15}
      assert_response :success
      expect(Reservation.exists?(reservation.id)).to be true
      
      reservation.reload
      expect(reservation.place_id).to eq(15)
    end
  end
  
  context 'song request' do
    
  end
  
  context 'song approve' do
    
  end
end