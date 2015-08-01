FactoryGirl.define do
  factory :person_detail do
    email 'user@gmail.com'
    with_mj
    
    trait :with_mj do
      before(:create) do |person_detail|
        person_detail.person=FactoryGirl.create(:music_jockey)
      end
    end
    
    trait :with_listener do
      before(:create) do |person_detail|
        person_detail.person=FactoryGirl.create(:listener)
      end
    end
   
  end
end
