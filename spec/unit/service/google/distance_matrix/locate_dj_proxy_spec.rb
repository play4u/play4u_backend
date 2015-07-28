require 'rails_helper'

describe Service::DistanceMatrix::LocateDJProxy do
  let(:listener){FactoryGirl.create(:listener)}
  let(:proxy){Service::DistanceMatrix::LocateDJProxy.new(listener)}
  let(:dj){FactoryGirl.create(:dj)}
  
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
    dj
    
    allow(AppConfig::ServiceSettings).to receive_messages(
    :google_distance_matrix_base_url => 'https://maps.googleapis.com/maps/api/distancematrix',
    :google_api_key => '123'
    )
  end
  
  context 'dj is 0mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(0)
    end
      
    it 'shall find a DJ' do
      djs_found = proxy.locate!
      expect(djs_found.length).to eql(1)
      expect(djs_found.first.stage_name).to eq(dj.stage_name)
    end
  end
  
  context 'dj is 2mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(2)
    end
    
    it 'shall find a DJ' do
      djs_found = proxy.locate!
      expect(djs_found.length).to eql(1)
      expect(djs_found.first.stage_name).to eq(dj.stage_name)
    end
  end
  
  context 'dj is 5mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(5)
    end
    
    it 'shall find a DJ' do
      djs_found = proxy.locate!
      expect(djs_found.length).to eql(1)
      expect(djs_found.first.stage_name).to eq(dj.stage_name)
    end
  end
  
  context 'dj is 7mi from listener' do
    before do
      allow(proxy.api_adapter).to receive(:send!).and_return(proxy.api_adapter)
      allow(proxy.api_adapter).to receive(:get_distance).and_return(7)
    end
    
    it 'shall NOT find a DJ' do
      djs_found = proxy.locate!
      expect(djs_found.length).to eql(0)
    end
  end
end