require 'rails_helper'
require 'rest_client'
require 'json'

describe 'distance matrix integration' do
  context 'apartment to parents house' do
    let(:url){'https://maps.googleapis.com/maps/api/distancematrix/json?origins=41.9021186,-87.6300499&destinations=42.118663,-87.83719500000001&language=en&units=imperial'}
    
    it 'shall retrieve distance' do
      response = RestClient.get(url)
      hash_response=JSON.parse(response.to_s)
      expect(hash_response['rows'].length).to be > 0
    end  
  end
end
