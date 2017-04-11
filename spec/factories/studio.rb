# frozen_string_literal: true

FactoryGirl.define do
  factory :studio do
    sequence(:name) { |n| "Studio #{n}" }
    city
    state { city.state }
    country { city.state.country }

    trait :invalid do
      name nil
    end
  end
end
