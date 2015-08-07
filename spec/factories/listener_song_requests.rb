FactoryGirl.define do
  factory :listener_song_request do
    association :song, :strategy => :build
    association :listener, :strategy => :build
    latitude 45.2
    longitude -87.45
  end
end
