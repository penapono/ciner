# frozen_string_literal: true
FactoryGirl.define do
  factory :question do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    user
    questionable_id { create(:movie).id }
    questionable_type Movie

    trait :invalid do
      title nil
      content nil
    end
  end
end
