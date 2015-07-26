require 'rails_helper'

# This is the first test suite written to configure
# and troubleshoot the test harness
RSpec.describe Artist, type: :model do
  context 'valid artist' do
    let(:artist){FactoryGirl.create(:artist)}
    
    it 'creates an artist' do
      expect(artist.name).to eq('smith')
    end
  end
end
