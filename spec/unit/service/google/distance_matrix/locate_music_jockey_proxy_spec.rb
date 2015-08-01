require 'rails_helper'

describe Service::DistanceMatrix::LocateMusicJockeyProxy do
  let(:listener){FactoryGirl.create(:listener)}
  let(:proxy){Service::DistanceMatrix::LocateMusicJockeyProxy.new(listener)}
  let(:mj){FactoryGirl.create(:music_jockey)}
  
  let(:distance_matrix_api_response){
    %q(
    {
         "destination_addresses" : [ "San Francisco, CA, USA" ],
         "origin_addresses" : [ "Seattle, WA, USA" ],
         "rows" : [
            {
               "elements" : [
                  {
                     "distance" : {
                        "text" : "808 mi",
                        "value" : 1299987
                     },
                     "duration" : {
                        "text" : "12 hours 26 mins",
                        "value" : 44739
                     },
                     "status" : "OK"
                  }
               ]
            }
         ],
         "status" : "OK"
      }
    )
  }
  
  before do
    mj
    
    allow(AppConfig::ServiceSettings).to receive_messages(
    :google_distance_matrix_base_url => 'https://maps.googleapis.com/maps/api/distancematrix',
    :google_api_key => '123'
    )
  end
  
  context 'mj is 0mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(0)
    end
      
    it 'shall find a MJ' do
      mjs_found = proxy.locate!
      expect(mjs_found.length).to eql(1)
      expect(mjs_found.first.stage_name).to eq(mj.stage_name)
    end
  end
  
  context 'mj is 2mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(2)
    end
    
    it 'shall find a MJ' do
      djs_found = proxy.locate!
      expect(djs_found.length).to eql(1)
      expect(djs_found.first.stage_name).to eq(mj.stage_name)
    end
  end
  
  context 'mj is 5mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(5)
    end
    
    it 'shall find a MJ' do
      mjs_found = proxy.locate!
      expect(mjs_found.length).to eql(1)
      expect(mjs_found.first.stage_name).to eq(mj.stage_name)
    end
  end
  
  context 'mj is 7mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(7)
    end
    
    it 'shall NOT find a MJ' do
      mjs_found = proxy.locate!
      expect(mjs_found.length).to eql(0)
    end
  end
end