# frozen_string_literal: true
FactoryGirl.define do
  factory :film_production_category do
    sequence(:name) { |n| "Film Production Category #{n}" }

    trait :invalid do
      name nil
    end
  end
end
