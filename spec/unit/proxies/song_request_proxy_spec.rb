require 'rails_helper'

describe Controllers::Proxies::SongRequestProxy do
  let(:listener){FactoryGirl.create(:listener)}
  let(:song){FactoryGirl.create(:song)}
  let(:position){Util::Position.new(listener.location.latitude,listener.location.longitude)}
  let(:proxy){Controllers::Proxies::SongRequestProxy.new(listener,song)}
  
  let(:music_jockey){
    mj=FactoryGirl.create(:music_jockey)
    mj.location=listener.location.dup
    mj.location.save!
    mj.save!
    mj
  }
  
  before do
    allow(AppConfig::DomainSettings).to receive(:search_radius).and_return(15.0)
  end
  
  context 'bottom-(left-1)' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.left-1
      music_jockey.location.latitude=proxy.search_perimeter.bottom
      music_jockey.location.save!
    end
    
    it 'shall NOT request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 0
   end
  end
  
  context 'bottom-(right+1)' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.right+1
      music_jockey.location.latitude=proxy.search_perimeter.bottom
      music_jockey.location.save!
    end
    
    it 'shall NOT request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 0
   end
  end
  
  context '(top+1)-middle' do
    before do
      music_jockey.location.longitude=(proxy.search_perimeter.right+proxy.search_perimeter.left)/2
      music_jockey.location.latitude=proxy.search_perimeter.top+1
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 0
   end
  end
  
  context '(bottom-1)-middle' do
    before do
      music_jockey.location.longitude=(proxy.search_perimeter.right+proxy.search_perimeter.left)/2
      music_jockey.location.latitude=proxy.search_perimeter.bottom-1
      music_jockey.location.save!
    end
    
    it 'shall NOT request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 0
   end
  end
  
  context 'bottom-middle' do
    before do
      music_jockey.location.longitude=(proxy.search_perimeter.right+proxy.search_perimeter.left)/2
      music_jockey.location.latitude=proxy.search_perimeter.bottom
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'top-middle' do
    before do
      music_jockey.location.longitude=(proxy.search_perimeter.right+proxy.search_perimeter.left)/2
      music_jockey.location.latitude=proxy.search_perimeter.top
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'right-middle' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.right
      music_jockey.location.latitude=(proxy.search_perimeter.top+proxy.search_perimeter.bottom)/2
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'left-middle' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.left
      music_jockey.location.latitude=(proxy.search_perimeter.top+proxy.search_perimeter.bottom)/2
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'bottom-right' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.right
      music_jockey.location.latitude=proxy.search_perimeter.bottom
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'bottom-left' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.left
      music_jockey.location.latitude=proxy.search_perimeter.bottom
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'top-right' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.right
      music_jockey.location.latitude=proxy.search_perimeter.top
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'top-left' do
    before do
      music_jockey.location.longitude=proxy.search_perimeter.left
      music_jockey.location.latitude=proxy.search_perimeter.top
      music_jockey.location.save!
    end
    
    it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'MJ 60 mi 180 degrees, 69 mi 90 degrees' do
    before do
      music_jockey.location.longitude-=1
      music_jockey.location.latitude+=1;
      music_jockey.location.save!
    end
    
    it 'shall NOT request the MJ' do
      proxy.request!
      expect(MusicJockeySongRequest.count).to be == 0
    end
  end
  
  context 'MJ 60 mi 180 degrees' do
    before do
      music_jockey.location.longitude-=1
      music_jockey.location.save!
    end
    
    it 'shall NOT request the MJ' do
      proxy.request!
      expect(MusicJockeySongRequest.count).to be == 0
    end
  end
  
  context 'MJ 60 mi 0 degrees' do
    before do
      music_jockey.location.longitude+=1
      music_jockey.location.save!
    end
    
    it 'shall NOT request the MJ' do
      proxy.request!
      expect(MusicJockeySongRequest.count).to be == 0
    end
  end
  
  context 'MJ 6.9 mi away 270 degrees' do
   before do
     music_jockey.location.latitude += 0.1
     music_jockey.save!
   end 
   
   it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'MJ 6.9 mi away 90 degrees' do
   before do
     music_jockey.location.latitude -= 0.1
     music_jockey.save!
   end 
   
   it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'MJ 12 mi away 180 degrees' do
   before do
     music_jockey.location.longitude -= 0.2
     music_jockey.save!
   end 
   
   it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'MJ 12 mi away 0 degrees' do
   before do
     music_jockey.location.longitude += 0.2
     music_jockey.save!
   end 
   
   it 'shall request the MJ' do
     proxy.request!
     expect(MusicJockeySongRequest.count).to be == 1
     mj=MusicJockeySongRequest.first.music_jockey
     expect(mj.id).to be == music_jockey.id
   end
  end
  
  context 'MJ 12 mi away' do
    
  end
  
  context 'MJ 15 mi away' do
    
  end
  
  context 'MJ 25 mi away' do
    
  end
end