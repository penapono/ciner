# frozen_string_literal: true
FactoryGirl.define do
  factory :professional do
    sequence(:name) { |n| "Film Production Category #{n}" }
    set_function
    birth DateTime.now
    country
    user

    trait :invalid do
      name nil
      set_function nil
    end
  end
end
