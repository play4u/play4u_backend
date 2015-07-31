FactoryGirl.define do
  factory :person_detail do
    email 'user@gmail.com'
    with_dj
    
    trait :with_dj do
      before(:create) do |person_detail|
        person_detail.person=FactoryGirl.create(:dj)
      end
    end
    
    trait :with_listener do
      before(:create) do |person_detail|
        person_detail.person=FactoryGirl.create(:listener)
      end
    end
   
  end
end
