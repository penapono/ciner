# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

country = Country.create(acronym: "BR", name: "Brasil")

state = State.create(acronym: "SP", name: "São Paulo", country: country)

campinas = City.create(name: "Campinas", state: state)
City.create(name: "Rio Claro", state: state)
City.create(name: "Valinhos", state: state)
City.create(name: "Piracicaba", state: state)
