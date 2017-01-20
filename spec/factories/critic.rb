# frozen_string_literal: true
FactoryGirl.define do
  factory :critic do
    sequence(:content) { |n| "Content #{n}" }
    user
    filmable_id create(:movie).id
    filmable_type Movie

    trait :invalid do
      name nil
      content nil
    end
  end
end
