FactoryGirl.define do
  factory :dj do
    stage_name 'hurricane'
    association :location, latitude: 26.533, longitude: -86.45, :strategy => :build
    
    after(:create) do |dj|
      person_detail=FactoryGirl.build(:person_detail)
      person_detail.person=dj
      person_detail.save!
    end
  end
end
