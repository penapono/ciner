# frozen_string_literal: true

FactoryBot.define do
  factory :critic do
    sequence(:content) { |n| "Content #{n}" }
    user
    filmable_id { create(:movie).id }
    filmable_type Movie
    rating 5.0

    trait :invalid do
      content nil
    end
  end
end
