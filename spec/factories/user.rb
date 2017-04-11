# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User Name #{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    birthday Date.today - 18.years
    cpf { Faker::CPF.pretty }
    cep "13060744"
    address "Rua Rubens Roberto Ciolfi"
    number 154
    neighbourhood "Vila União"
    state
    city
    gender :men
    nickname "penapono"
    password "password"
    password_confirmation "password"
    terms_of_use true

    role :free

    trait :invalid do
      name nil
      email nil
      birthday nil
      cpf nil
      cep nil
      address nil
      number nil
      neighbourhood nil
      state nil
      city nil
      gender nil
      nickname nil
      password nil
      password_confirmation nil
      terms_of_use nil
    end

    trait :admin do
      role :admin
    end
  end
end
