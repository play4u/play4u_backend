require 'rails_helper'

RSpec.describe ListenersController, type: :controller do
  render_views
  
  let(:listener){FactoryGirl.create(:listener)}
  let(:position){Util::Position.new(54.12,-88.23)}
  let(:expected_first_name){'tom'}
  
  let(:params){
    {
      id: listener.id,
      latitude: position.latitude,
      longitude: position.longitude
    }
  }
  
  context 'show' do
    it 'shall show' do
      expect(Listener.exists?(listener.id)).to be true
      get :show, params
      assert_response :success, response.body
      listener.reload
      expect(listener.location.latitude).to eq(position.latitude)
      expect(listener.location.longitude).to eq(position.longitude)
    end
  end
  
  context 'create' do
    let(:params){
    {
      email: 'listener@music.com',
      first_name: 'tom',
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
      listener=person_detail.person
      expect(listener.location).to be_truthy
      expect(listener.location.latitude).to eq(params[:latitude].to_f)
      expect(listener.location.longitude).to eq(params[:longitude].to_f)
    end
  end
  
  context 'update' do
    let(:params_with_first_name){params.merge(first_name: expected_first_name)}
    
    it 'shall update' do
      expect(Listener.exists?(listener.id)).to be true
      old_first_name=listener.first_name
      put :update, params_with_first_name
      assert_response :success, response.body
      listener.reload
      expect(listener.first_name).to eq(expected_first_name)
      expect(listener.location.latitude).to eq(position.latitude)
      expect(listener.location.longitude).to eq(position.longitude)
    end
  end
  
  context 'delete' do
    it 'shall destroy' do
      expect(Listener.exists?(listener.id)).to be true
      delete :destroy, params
      assert_response :success, response.body
      expect(Listener.exists?(listener.id)).to be false
    end
  end
end
