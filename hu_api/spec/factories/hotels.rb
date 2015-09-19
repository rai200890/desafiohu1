FactoryGirl.define do
  factory :hotel do
    sequence :name do |n|
      "Hotel#{n}"
    end
    trait :with_city do
      city
    end
    trait :from_city_a do
      association :city, :a
    end
    trait :from_city_b do
      association :city, :b
    end
  end

end
