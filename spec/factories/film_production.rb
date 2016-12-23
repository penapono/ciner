# frozen_string_literal: true
FactoryGirl.define do
  factory :film_production do
    sequence(:original_title) { |n| "Film Production #{n}" }
    sequence(:title) { |n| "Production #{n}" }
    year 2016
    length 90
    film_production_category
    synopsis "Synopsis"
    release DateTime.now
    brazilian_release DateTime.now
    country
    age_range

    trait :invalid do
      original_title nil
      year nil
      length nil
    end
  end
end
