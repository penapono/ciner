# frozen_string_literal: true

FactoryGirl.define do
  factory :movie do
    sequence(:original_title) { |n| "Film Production #{n}" }
    sequence(:title) { |n| "Production #{n}" }
    year 2016
    length 90
    synopsis "Synopsis"
    release Date.now
    brazilian_release Date.now
    age_range

    trait :invalid do
      original_title nil
      year nil
      length nil
    end
  end
end
