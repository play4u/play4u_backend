FactoryGirl.define do
  factory :song do
    name  'rainforest'
    association :artist, strategy: :build
  end
end
