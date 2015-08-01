FactoryGirl.define do
  factory :music_jockey do
    stage_name 'hurricane'
    association :location, latitude: 26.533, longitude: -86.45, :strategy => :build
    
    after(:create) do |mj|
      person_detail=FactoryGirl.build(:person_detail)
      person_detail.person=mj
      person_detail.save!
    end
  end
end
