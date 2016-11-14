# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


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

country = Country.find_or_create_by(name: 'Brasil', acronym: 'BR')

State.find_or_create_by(name: 'Acre', acronym: 'AC', country: country)
State.find_or_create_by(name: 'Alagoas', acronym: 'AL', country: country)
State.find_or_create_by(name: 'Amapá', acronym: 'AP', country: country)
State.find_or_create_by(name: 'Amazonas', acronym: 'AM', country: country)
State.find_or_create_by(name: 'Bahia', acronym: 'BA', country: country)
State.find_or_create_by(name: 'Ceará', acronym: 'CE', country: country)
State.find_or_create_by(name: 'Distrito Federal', acronym: 'DF', country: country)
State.find_or_create_by(name: 'Espírito Santo', acronym: 'ES', country: country)
State.find_or_create_by(name: 'Goiás', acronym: 'GO', country: country)
State.find_or_create_by(name: 'Maranhão', acronym: 'MA', country: country)
State.find_or_create_by(name: 'Mato Grosso', acronym: 'MT', country: country)
State.find_or_create_by(name: 'Mato Grosso do Sul', acronym: 'MS', country: country)
State.find_or_create_by(name: 'Minas Gerais', acronym: 'MG', country: country)
State.find_or_create_by(name: 'Paraná', acronym: 'PR', country: country)
State.find_or_create_by(name: 'Paraíba', acronym: 'PB', country: country)
State.find_or_create_by(name: 'Pará', acronym: 'PA', country: country)
State.find_or_create_by(name: 'Pernambuco', acronym: 'PE', country: country)
State.find_or_create_by(name: 'Piauí', acronym: 'PI', country: country)
State.find_or_create_by(name: 'Rio Grande do Norte', acronym: 'RN', country: country)
State.find_or_create_by(name: 'Rio Grande do Sul', acronym: 'RS', country: country)
State.find_or_create_by(name: 'Rio de Janeiro', acronym: 'RJ', country: country)
State.find_or_create_by(name: 'Rondônia', acronym: 'RO', country: country)
State.find_or_create_by(name: 'Roraima', acronym: 'RR', country: country)
State.find_or_create_by(name: 'Santa Catarina', acronym: 'SC', country: country)
State.find_or_create_by(name: 'Sergipe', acronym: 'SE', country: country)
state = State.find_or_create_by(name: 'São Paulo', acronym: 'SP', country: country)
State.find_or_create_by(name: 'Tocantins', acronym: 'TO', country: country)

City.find_or_create_by(name: "Campinas", state: state)
City.find_or_create_by(name: "Monte Mor", state: state)
City.find_or_create_by(name: "Nova Odessa", state: state)
City.find_or_create_by(name: "Rio Claro", state: state)
City.find_or_create_by(name: "Valinhos", state: state)
City.find_or_create_by(name: "Piracicaba", state: state)
