FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User Name #{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password "senha123"
    birthday Date.today - 18.years
    role 1
    city

    trait :invalid do
      name nil
      email nil
      birthday nil
      role nil
      city nil
    end
  end
end
