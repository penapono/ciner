# frozen_string_literal: true

FactoryBot.define do
  factory :user_filmable do
    user
    filmable_id { create(:movie).id }
    filmable_type Movie
    action 1

    trait :invalid do
      user nil
      filmable_id nil
      filmable_type nil
      action nil
    end
  end
end
