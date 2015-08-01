require 'rails_helper'

RSpec.describe MusicJockeysController, type: :controller do
  render_views
  
  let(:mj){FactoryGirl.create(:music_jockey)}
  let(:position){Util::Position.new(54.12,-88.23)}
  let(:expected_stage_name){'new stagename'}
  
  let(:params){
    {
      id: mj.id,
      latitude: position.latitude,
      longitude: position.longitude
    }
  }
  
  context 'display a mj' do
    it 'shall show' do
      expect(MusicJockey.exists?(mj.id)).to be true
      get :show, params
      assert_response :success, response.body
      mj.reload
      expect(mj.location.latitude).to eq(position.latitude)
      expect(mj.location.longitude).to eq(position.longitude)
    end
  end
  
  context 'create a mj' do
    let(:params){
    {
      email: 'mj@mjs.com',
      stage_name: 'mj name',
      latitude: position.latitude,
      longitude: position.longitude
    }
  }
    
    it 'shall create' do
      expect(PersonDetail.find_by(email: params[:email])).to be_falsey
      post :create, params
      assert_response :success, response.body
      expect(PersonDetail.find_by(email: params[:email])).to be_truthy
      
      person_detail=PersonDetail.find_by(email: params[:email])
      expect(person_detail).to be_truthy
      mj=person_detail.person
      expect(mj.location).to be_truthy
      expect(mj.location.latitude).to eq(params[:latitude].to_f)
      expect(mj.location.longitude).to eq(params[:longitude].to_f)
    end
  end
  
  context 'update a mj' do
    let(:params_with_stage_name){params.merge(stage_name: expected_stage_name)}
    
    it 'shall update' do
      expect(MusicJockey.exists?(mj.id)).to be true
      old_stage_name=mj.stage_name
      put :update, params_with_stage_name
      assert_response :success, response.body
      mj.reload
      expect(mj.stage_name).to eq(expected_stage_name)
      expect(mj.location.latitude).to eq(position.latitude)
      expect(mj.location.longitude).to eq(position.longitude)
    end
  end
  
  context 'delete a mj' do
    it 'shall destroy' do
      expect(MusicJockey.exists?(mj.id)).to be true
      delete :destroy, params
      assert_response :success, response.body
      expect(MusicJockey.exists?(mj.id)).to be false
    end
  end
end
