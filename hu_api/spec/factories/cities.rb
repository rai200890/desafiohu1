FactoryGirl.define do
  factory :city do
    sequence :name do |n|
      "City#{n}"
    end
    trait :with_city do
      city
    end
    trait :a do
      name "City A"
    end
    trait :b do
      name "City B"
    end
  end
end
