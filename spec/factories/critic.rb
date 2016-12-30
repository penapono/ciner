# frozen_string_literal: true
FactoryGirl.define do
  factory :critic do
    sequence(:name) { |n| "Critic #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    user
    city { user.city }
    state { city.state }
    country { city.state.country }

    trait :invalid do
      name nil
      content nil
    end
  end
end
