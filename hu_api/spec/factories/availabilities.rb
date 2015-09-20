FactoryGirl.define do
  factory :availability do
    association :hotel
    day Date.today
  end
  trait :with_day do
    day Date.today
  end
  trait :without_day do
    day nil
  end
  trait :with_hotel do
    association :hotel
  end
  trait :without_hotel do
    hotel nil
  end
end
