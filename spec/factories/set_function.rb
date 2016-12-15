FactoryGirl.define do
  factory :set_function do
    sequence(:name) { |n| "Set Function #{n}" }
    description "Set Function Description"

    trait :invalid do
      name nil
    end
  end
end
