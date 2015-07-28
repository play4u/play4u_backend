FactoryGirl.define do
  factory :listener do
    first_name  'mark'
    email 'coollistener@gmail.com'
    association :location, latitude: 56, longitude: -76, :strategy => :build
  end
end
