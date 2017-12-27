# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "Content #{n}" }
    user
    commentable_id { create(:question).id }
    commentable_type Question

    trait :invalid do
      content nil
      user nil
      commentable_id nil
      commentable_type nil
    end
  end
end
