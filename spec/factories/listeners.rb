FactoryGirl.define do
  factory :listener do
    first_name  'mark'
    association :location, latitude: 56, longitude: -76, :strategy => :build
    
    after(:create) do |listener|
      person_detail=FactoryGirl.build(:person_detail)
      person_detail.person=listener
      person_detail.save!
    end
  end
end
