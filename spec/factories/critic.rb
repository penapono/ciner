# frozen_string_literal: true
FactoryGirl.define do
  factory :critic do
    sequence(:name) { |n| "Critic #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    user

    trait :invalid do
      name nil
      content nil
    end
  end
end
