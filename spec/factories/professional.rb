# frozen_string_literal: true

FactoryBot.define do
  factory :professional do
    sequence(:name) { |n| "Professional Name #{n}" }
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

    set_function
    user

    trait :invalid do
      name nil
      set_function nil
    end
  end
end
