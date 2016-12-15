FactoryGirl.define do
  factory :age_range do
    sequence(:name) { |n| "Age Range +#{n}" }
    age 18

    trait :invalid do
      name nil
      age nil
    end
  end
end
