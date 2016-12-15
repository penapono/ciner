FactoryGirl.define do
  factory :studio do
    sequence(:name) { |n| "Studio #{n}" }
    creation DateTime.now
    country

    trait :invalid do
      name nil
    end
  end
end
