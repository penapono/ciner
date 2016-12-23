# frozen_string_literal: true
FactoryGirl.define do
  factory :country do
    sequence(:acronym) { |n| "Country Acronym #{n}" }
    sequence(:name) { |n| "Country #{n}" }

    trait :invalid do
      acronym nil
      name nil
    end
  end
end
