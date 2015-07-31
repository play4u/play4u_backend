require 'rails_helper'
require 'rest_client'
require 'json'

describe ReservationsController, type: :controller do
  render_views
  let(:reservation){FactoryGirl.create(:reservation)}
  let(:dj){reservation.dj}
  let(:listener){reservation.listener}
  
  before do
    proxy=double()
    allow(proxy).to receive(:send!)
    
    allow(Service::Mailgun::EmailSongApprovalProxy)
    .to receive(:new)
    .and_return(proxy)
    
    allow(Service::Mailgun::EmailCancelReservationProxy)
    .to receive(:new)
    .and_return(proxy)
    
    allow(Service::Mailgun::EmailReservationUpdateProxy)
    .to receive(:new)
    .and_return(proxy)
  end
  
  context 'cancel reservation' do
    it 'shall cancel a reservation' do
      expect(Reservation.exists?(reservation.id)).to be true
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
  
  context 'song approve' do
    let(:dj){FactoryGirl.create(:dj)}
    let(:listener_song_request){FactoryGirl.create(:listener_song_request)}
    let(:place_id){561332}
    let(:response_json_hash){JSON.parse(response.body)}
    let(:new_reservation){Reservation.find(response_json_hash['reservation']['id'].to_i)}
    
    let(:params){
      {
        start_year: 2015,
        start_month: 7,
        start_day: 30,
        start_hour: 21,
        start_minute: 0,
        end_year: 2015,
        end_month: 7,
        end_day: 30,
        end_hour: 23,
        end_minute:30,
        description: 'nice event',
        place_id: place_id,
        dj_id: dj.id,
        listener_song_request_id: listener_song_request.id  
      }
    }
    
    it 'shall approve a song' do
      post 'create', params
      assert_response :success
      expect(response.body.length).to be > 0
      expect(new_reservation.description).to eq('nice event')
      expect(new_reservation.dj.id).to eq(dj.id)
      expect(new_reservation.listener.id).to eq(listener_song_request.listener.id)
      expect(new_reservation.place_id).to eq(place_id)
      
      start_time=new_reservation.start_time
      expect(start_time).to be_truthy
      expect(start_time.year).to eq(params[:start_year])
      expect(start_time.month).to eq(params[:start_month])
      expect(start_time.day).to eq(params[:start_day])
      expect(start_time.hour).to eq(params[:start_hour])
      expect(start_time.min).to eq(params[:start_minute])
      
      end_time=new_reservation.end_time
      expect(end_time).to be_truthy
      expect(end_time.year).to eq(params[:end_year])
      expect(end_time.month).to eq(params[:end_month])
      expect(end_time.day).to eq(params[:end_day])
      expect(end_time.hour).to eq(params[:end_hour])
      expect(end_time.min).to eq(params[:end_minute])
    end
  end
end