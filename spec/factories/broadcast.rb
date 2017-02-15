# frozen_string_literal: true
FactoryGirl.define do
  factory :broadcast do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    user

    trait :invalid do
      title nil
      content nil
    end
  end
end
