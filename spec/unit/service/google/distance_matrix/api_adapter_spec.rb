require 'rails_helper'
require 'rest_client'

describe Service::DistanceMatrix::Adapters::ApiAdapter do
  let(:listener){FactoryGirl.create(:listener)}
  let(:adapter){Service::DistanceMatrix::Adapters::ApiAdapter.new}
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
    allow(RestClient).to receive(:get).and_return(distance_matrix_api_response)
    
    allow(AppConfig::ServiceSettings).to receive_messages(
    :google_distance_matrix_base_url => 'https://maps.googleapis.com/maps/api/distancematrix',
    :google_api_key => '123'
    )
    
    adapter
    .set_origin(listener.location.get_position)
    .set_destination(dj.location.get_position)
  end
  
  it 'shall parse the distance' do
    expect(adapter.send!.get_distance).to eql(808)
  end
end