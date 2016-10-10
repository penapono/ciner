FactoryGirl.define do
  factory :state do
    sequence(:acronym) { |n| "State Acronym #{n}" }
    sequence(:name) { |n| "State #{n}" }
    country

    trait :invalid do
      acronym nil
      name nil
      country nil
    end
  end
end
