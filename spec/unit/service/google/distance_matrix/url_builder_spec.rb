require 'rails_helper'
require 'uri'

describe Service::DistanceMatrix::Builders::URLBuilder do
  let(:origin){Util::Position.new(1,2)}
  let(:destination){Util::Position.new(5,-7)}
  let(:builder){Service::DistanceMatrix::Builders::URLBuilder.new}
  
  before do
    allow(AppConfig::ServiceSettings).to receive_messages(
    :google_distance_matrix_base_url => 'https://maps.googleapis.com/maps/api/distancematrix',
    :google_api_key => '123'
    )
    
    builder.set_origin(origin).set_destination(destination)
  end
  
  it 'builds url' do
    actual_uri=URI(builder.build)
    expected_url='https://maps.googleapis.com/maps/api/distancematrix/json?origin=1,2&destinations=5,-7&language=en&units=imperial&key=123'
    
    expect(actual_uri.to_s).to eql(expected_url)
  end
end
