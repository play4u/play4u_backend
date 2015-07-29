FactoryGirl.define do
  factory :listener_song_request do
    association :song, :strategy => :build
    association :listener, :strategy => :build
  end
end
