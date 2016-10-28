# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

country = Country.find_or_create_by(acronym: "BR", name: "Brasil")

state = State.find_or_create_by(acronym: "SP", name: "São Paulo", country: country)

campinas = City.find_or_create_by(name: "Campinas", state: state)
City.find_or_create_by(name: "Rio Claro", state: state)
City.find_or_create_by(name: "Valinhos", state: state)
City.find_or_create_by(name: "Piracicaba", state: state)

admin_user = User.find_or_initialize_by(name: 'Pedro Naponoceno',
                      email: 'pnaponoceno@caiena.net',
                      role: 0)
admin_user.password = 'ciner123'

admin_user.save(validate: false)

free_user = User.find_or_initialize_by(name: 'Rubens Junior',
                     email: 'rubens.arjr@gmail.com',
                     role: 1)

free_user.password = 'ciner123'

free_user.save(validate: false)
