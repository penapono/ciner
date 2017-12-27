# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "City #{n}" }
    state

    trait :invalid do
      name nil
      state nil
    end
  end
end
