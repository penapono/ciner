# frozen_string_literal: true
FactoryGirl.define do
  factory :ciner_new do
    sequence(:name) { |n| "CinerNew #{n}" }
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
