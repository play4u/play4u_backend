require 'rails_helper'
require 'uri'

describe Service::DistanceMatrix::Builders::URLBuilder do
  let(:origin){Util::Position.new(1,2)}
  let(:destinations){[Util::Position.new(5,-7)]}
  let(:builder){Service::DistanceMatrix::Builders::URLBuilder.new}
  
  before do
    allow(Config::ServiceSettings).to receive_messages(
    :google_distance_matrix_base_url => 'https://maps.googleapis.com/maps/api/distancematrix',
    :google_api_key => 123
    )
  end
  
  it 'builds url' do
    actual_uri=URI(builder.build)
    puts actual_uri
  end
end
