require 'rails_helper'

RSpec.describe DjsController, type: :controller do
  render_views
  
  let(:dj){FactoryGirl.create(:dj)}
  let(:position){Util::Position.new(54.12,-88.23)}
  let(:expected_stage_name){'new stagename'}
  
  let(:params){
    {
      id: dj.id,
      latitude: position.latitude,
      longitude: position.longitude
    }
  }
  
  context 'display a DJ' do
    it 'shall show' do
      expect(Dj.exists?(dj.id)).to be true
      get :show, params
      assert_response :success, response.body
      dj.reload
      expect(dj.location.latitude).to eq(position.latitude)
      expect(dj.location.longitude).to eq(position.longitude)
    end
  end
  
  context 'create a DJ' do
    let(:params){
    {
      email: 'dj@djs.com',
      stage_name: 'DJ name',
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
      dj=person_detail.person
      expect(dj.location).to be_truthy
      expect(dj.location.latitude).to eq(params[:latitude].to_f)
      expect(dj.location.longitude).to eq(params[:longitude].to_f)
    end
  end
  
  context 'update a DJ' do
    let(:params_with_stage_name){params.merge(stage_name: expected_stage_name)}
    
    it 'shall update' do
      expect(Dj.exists?(dj.id)).to be true
      old_stage_name=dj.stage_name
      put :update, params_with_stage_name
      assert_response :success, response.body
      dj.reload
      expect(dj.stage_name).to eq(expected_stage_name)
      expect(dj.location.latitude).to eq(position.latitude)
      expect(dj.location.longitude).to eq(position.longitude)
    end
  end
  
  context 'delete a DJ' do
    it 'shall destroy' do
      expect(Dj.exists?(dj.id)).to be true
      delete :destroy, params
      assert_response :success, response.body
      expect(Dj.exists?(dj.id)).to be false
    end
  end
end
