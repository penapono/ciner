# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
State.find_or_create_by(name: 'Tocantins', acronym: 'TO', country: country)
state = State.find_or_create_by(name: 'São Paulo', acronym: 'SP', country: country)

City.find_or_create_by(name: "Monte Mor", state: state)
City.find_or_create_by(name: "Nova Odessa", state: state)
City.find_or_create_by(name: "Rio Claro", state: state)
City.find_or_create_by(name: "Valinhos", state: state)
City.find_or_create_by(name: "Piracicaba", state: state)
City.find_or_create_by(name: "Sorocaba", state: state)
City.find_or_create_by(name: "Santa Gertrudes", state: state)
city = City.find_or_create_by(name: "Campinas", state: state)

# ------------------------------ Guilherme ------------------------------

admin_user = User.find_or_initialize_by(
  name: 'Administrador Ciner',
  email: 'admin@ciner.com',
  role: 0,
  registered_at: Date.parse("01/09/2016"),
  city: city,
  state: state,
  birthday: Date.parse("21/09/1994"),
  gender: :men,
  biography: 'Sou administrador',
  terms_of_use: true
)

admin_user.password = 'ciner123'
admin_user.password_confirmation = 'ciner123'

admin_user.save(validate: false)

# ------------------------------ Marquinhos ------------------------------

admin_user = User.find_or_initialize_by(
  name: 'Administrador Ciner',
  email: 'admin@ciner.com',
  role: 0,
  registered_at: Date.parse("01/09/2016"),
  city: city,
  state: state,
  birthday: Date.parse("21/09/1994"),
  gender: :men,
  biography: 'Sou administrador',
  terms_of_use: true
)

admin_user.password = 'ciner123'
admin_user.password_confirmation = 'ciner123'

admin_user.save(validate: false)

# ------------------------------ Thiago ------------------------------

admin_user = User.find_or_initialize_by(
  name: 'Administrador Ciner',
  email: 'admin@ciner.com',
  role: 0,
  registered_at: Date.parse("01/09/2016"),
  city: city,
  state: state,
  birthday: Date.parse("21/09/1994"),
  gender: :men,
  biography: 'Sou administrador',
  terms_of_use: true
)

admin_user.password = 'ciner123'
admin_user.password_confirmation = 'ciner123'

admin_user.save(validate: false)

# ------------------------------ Admin ------------------------------

admin_user = User.find_or_initialize_by(
  name: 'Administrador Ciner',
  email: 'admin@ciner.com',
  role: 0,
  registered_at: Date.parse("01/09/2016"),
  city: city,
  state: state,
  birthday: Date.parse("21/09/1994"),
  gender: :men,
  biography: 'Sou administrador',
  terms_of_use: true
)

admin_user.password = 'ciner123'
admin_user.password_confirmation = 'ciner123'

admin_user.save(validate: false)

# ------------------------------ Pedro ------------------------------

admin_user = User.find_or_initialize_by(
  name: 'Pedro Naponoceno',
  email: 'pnaponoceno@caiena.net',
  role: 0,
  registered_at: Date.parse("01/09/2016"),
  city: city,
  state: state,
  birthday: Date.parse("21/09/1994"),
  gender: :men,
  biography: 'Sou administrador',
  terms_of_use: true
)

admin_user.password = 'ciner123'
admin_user.password_confirmation = 'ciner123'

admin_user.save(validate: false)

# ------------------------------ Comum ------------------------------

free_user = User.find_or_initialize_by(
  name: 'Usuário Ciner',
  email: 'free@ciner.com',
  role: 1,
  registered_at: Date.parse("01/09/2016"),
  city: city,
  state: state,
  birthday: Date.parse("28/02/1992"),
  gender: :men,
  biography: 'Sou o Usuário comum, vamos ao cinema?',
  terms_of_use: true
)

free_user.password = 'ciner123'
free_user.password_confirmation = 'ciner123'

free_user.save(validate: false)

# ------------------------------ Rubens ------------------------------

free_user = User.find_or_initialize_by(
  name: 'Rubens Junior',
  email: 'rubens.arjr@gmail.com',
  role: 1,
  registered_at: Date.parse("01/09/2016"),
  city: city,
  state: state,
  birthday: Date.parse("28/02/1992"),
  gender: :men,
  biography: 'Sou o Rubão, seu amigão, vamos no cinema?',
  terms_of_use: true
)

free_user.password = 'ciner123'
free_user.password_confirmation = 'ciner123'

free_user.save(validate: false)

# ------------------------------ Funções no Set ------------------------------

names = [
  "Produção", "Produção de Set", "Produção Executiva",
  "Direção", "Roteiro", "Direção de Fotografia", "Sound Designer",
  "Elenco", "Direção de Arte", "Edição", "Efeitos Visuais",
  "Assistente de Direção", "Câmera", "Casting", "Trilha Sonora",
  "Trilha Sonora Original", "História", "Figurino", "Continuidade",
  "Assistente de Fotografia", "Assistente de Som", "Captação de Som",
  "Edição de Som", "Colorização/Finalização", "Maquiagem", "Still",
  "Making Of", "Dublê", "Foley", "Figuração", "Contrarregra",
  "Narração", "Dublagem", "Agradecimentos"
]

names.each do |name|
  set_function =
    SetFunction.find_or_create_by(name: name, description: name)
end

# ------------------------- Classificação Indicativa -------------------------

AgeRange.find_or_create_by(name: 'Livre', age: 0)
AgeRange.find_or_create_by(name: '10 anos', age: 10)
AgeRange.find_or_create_by(name: '12 anos', age: 12)
AgeRange.find_or_create_by(name: '14 anos', age: 14)
AgeRange.find_or_create_by(name: '16 anos', age: 16)
AgeRange.find_or_create_by(name: '18 anos', age: 18)

# ---------------------------------- Gêneros ----------------------------------

FilmProductionCategory.find_or_create_by(name: 'Ação', description: 'Action')
FilmProductionCategory.find_or_create_by(name: 'Animação', description: 'Animation')
FilmProductionCategory.find_or_create_by(name: 'Comédia', description: 'Comedy')
FilmProductionCategory.find_or_create_by(name: 'Documentário', description: 'Documentary')
FilmProductionCategory.find_or_create_by(name: 'Família', description: 'Family')
FilmProductionCategory.find_or_create_by(name: 'Film-Noir', description: 'Film-Noir')
FilmProductionCategory.find_or_create_by(name: 'Terror', description: 'Horror')
FilmProductionCategory.find_or_create_by(name: 'Musical', description: 'Musical')
FilmProductionCategory.find_or_create_by(name: 'Romance', description: 'Romance')
FilmProductionCategory.find_or_create_by(name: 'Esporte', description: 'Sport')
FilmProductionCategory.find_or_create_by(name: 'Guerra', description: 'War')
FilmProductionCategory.find_or_create_by(name: 'Aventura', description: 'Adventure')
FilmProductionCategory.find_or_create_by(name: 'Biografia', description: 'Biography')
FilmProductionCategory.find_or_create_by(name: 'Crime', description: 'Crime')
FilmProductionCategory.find_or_create_by(name: 'Drama', description: 'Drama')
FilmProductionCategory.find_or_create_by(name: 'Fantasia', description: 'Fantasy')
FilmProductionCategory.find_or_create_by(name: 'História', description: 'History')
FilmProductionCategory.find_or_create_by(name: 'Show', description: 'Music')
FilmProductionCategory.find_or_create_by(name: 'Mistério', description: 'Mystery')
FilmProductionCategory.find_or_create_by(name: 'Ficção Científica', description: 'Sci-Fi')
FilmProductionCategory.find_or_create_by(name: 'Faroeste', description: 'Western')
FilmProductionCategory.find_or_create_by(name: 'Suspense', description: 'Thriller')


