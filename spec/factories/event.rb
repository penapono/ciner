# frozen_string_literal: true
FactoryGirl.define do
  factory :event do
    sequence(:title) { |n| "Oscar #{n}" }
    description "Description"
    event_date Date.today

    trait :invalid do
      title nil
      description nil
    end
  end
end
