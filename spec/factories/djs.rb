FactoryGirl.define do
  factory :dj do
    stage_name 'hurricane'
    email 'cooldj@gmail.com'
    association :location, latitude: 26.533, longitude: -86.45, :strategy => :build
  end
end
