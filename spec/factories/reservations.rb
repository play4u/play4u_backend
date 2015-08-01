FactoryGirl.define do
  factory :reservation do
    start_time  Time.now
    end_time    Time.now
    place_id    123
    description 'Will play asap!'
    
    association :music_jockey, :strategy => :build
    association :song, :strategy => :build
    association :listener, :strategy => :build
  end
end
