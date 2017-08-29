# frozen_string_literal: true

module FilmProfitable
  extend ActiveSupport::Concern

  API_KEY   = "8802a6c6583ac6edc44bea8d577baa97"
  BASE_URL  = "https://api.themoviedb.org/3"
  LANGUAGE  = "language=pt-BR"

  included do
    def genre_pt
      return unless omdb_genre
      genres = omdb_genre.split(",").map(&:strip)

      pt_genre = []

      genres.each do |genre|
        category = FilmProductionCategory.find_by(description: genre)
        pt_genre << category.name if category
      end

      pt_genre.to_sentence
    end

    def rated_pt
      return omdb_rated if !omdb_rated.blank? && omdb_rated == "Livre"
      return omdb_rated[0..1] + " anos" unless omdb_rated.blank?
      ""
    end

    def writers_pt
      return "" unless omdb_writers
      omdb_writers.gsub("(as)", "(como)")
                  .gsub("(author)", "(autor)")
                  .gsub("(book)", "(livro)")
                  .gsub("(characters)", "(personagens)")
                  .gsub("(co-author)", "(co-autor)")
                  .gsub("(from the stage musical book by)", "(peça musical)")
                  .gsub("(novel)", "(romance)")
                  .gsub("(original play)", "(peça original)")
                  .gsub("(original screen play)", "(roteiro original)")
                  .gsub("(original story by)", "(história original)")
                  .gsub("(play)", "(peça)")
                  .gsub("(screenplay)", "(roteiro)")
                  .gsub("(short story)", "(conto)")
                  .gsub("(story)", "(história)")
                  .gsub("(uncredited)", "(não creditado)")
                  .gsub("(with the partial use of ideas by)", "(com o uso parcial de idéias)")
                  .gsub("(written by)", "(escrito)")
                  .gsub("(story by)", "(história)")
                  .gsub("(adaptation)", "(adaptação)")
                  .gsub("(based upon his play)", "(peça)")
                  .gsub("(written for the screen by)", "(adaptação)")
                  .gsub("(based on the manga by)", "(criador do mangá)")
                  .gsub("(books)", "(livros)")
                  .gsub("(scenario)", "(enredo)")
                  .gsub("(scenario consultant)", "(consultor de enredo)")
                  .gsub("(based on characters created by)", "(criador dos personagens)")
                  .gsub("(characters)", "(personagens)")
                  .gsub("(based on the book by)", "(livro)")
                  .gsub("(original idea)", "(ideia original)")
                  .gsub("(additional story material)", "(material adicional à história)")
                  .gsub("(based upon his play)", "(peça)")
                  .gsub("(collaboration)", "(colaborador)")
                  .gsub("(from the novel by)", "(romance)")
                  .gsub("(based on the novel by)", "(romance)")
                  .gsub("(based on a story)", "(história)")
                  .gsub("(dialogue)", "(diálogos)")
                  .gsub("(based on a film by)", "(filme original)")
                  .gsub("(english adaptation)", "(adaptação para o inglês)")
                  .gsub("(screen story by)", "(adaptação)")
    end

    def countries_str
      countries = self.countries
      return "" unless countries

      countries =
        countries.gsub("Argentina", "Argentina")
                 .gsub("Australia", "Austrália")
                 .gsub("Austria", "Áustria")
                 .gsub("Belgium", "Bélgica")
                 .gsub("Brazil", "Brasil")
                 .gsub("Bulgaria", "Bulgária")
                 .gsub("Canada", "Canadá")
                 .gsub("China", "China")
                 .gsub("Costa Rica", "Costa Rica")
                 .gsub("Czech Republic", "República Tcheca")
                 .gsub("Denmark", "Dinamarca")
                 .gsub("Colombia", "Colômbia")
                 .gsub("Finland", "Finlândia")
                 .gsub("France", "França")
                 .gsub("Germany", "Alemanha")
                 .gsub("Greece", "Grécia")
                 .gsub("Hong Kong", "Hong Kong")
                 .gsub("Hungary", "Hungria")
                 .gsub("Iceland", "Islândia")
                 .gsub("India", "Índia")
                 .gsub("Iran", "Irã")
                 .gsub("Ireland", "Irlanda")
                 .gsub("Italy", "Itália")
                 .gsub("Japan", "Japão")
                 .gsub("Malaysia", "Malásia")
                 .gsub("Mexico", "México")
                 .gsub("Netherlands", "Holanda")
                 .gsub("New Zealand", "Nova Zelândia")
                 .gsub("Pakistan", "Paquistão")
                 .gsub("Poland", "Polônia")
                 .gsub("Portugal", "Portugal")
                 .gsub("Romania", "Romênia")
                 .gsub("Russia", "Rússia")
                 .gsub("Singapore", "Singapura")
                 .gsub("South Africa", "África do Sul")
                 .gsub("Spain", "Espanha")
                 .gsub("Sweden", "Suécia")
                 .gsub("Switzerland", "Suíça")
                 .gsub("Thailand", "Tailândia")
                 .gsub("UK", "Reino Unido")
                 .gsub("United Kingdom", "Reino Unido")
                 .gsub("United States", "EUA")
                 .gsub("USA", "EUA")
                 .gsub("Afghanistan", "Afeganistão")
                 .gsub("Åland Islands", "Ilhas de Aland")
                 .gsub("Albania", "Albânia")
                 .gsub("Algeria", "Argélia")
                 .gsub("American Samoa", "Samoa Americana")
                 .gsub("Andorra", "Andorra")
                 .gsub("Angola", "Angola")
                 .gsub("Anguilla", "Anguila")
                 .gsub("Antarctica", "Antártica")
                 .gsub("Antigua and Barbuda", "Antígua e Barbuda")
                 .gsub("Armenia", "Armênia")
                 .gsub("Aruba", "Aruba")
                 .gsub("Azerbaijan", "Azerbaijão")
                 .gsub("Bahamas", "Bahamas")
                 .gsub("Bahrain", "Bahrein")
                 .gsub("Bangladesh", "Bangladesh")
                 .gsub("Barbados", "Barbados")
                 .gsub("Belarus", "Bielorrússia")
                 .gsub("Belize", "Belize")
                 .gsub("Benin", "Benim")
                 .gsub("Bermuda", "Bermudas")
                 .gsub("Bhutan", "Butão")
                 .gsub("Bolivia", "Bolívia")
                 .gsub("Bonaire, Sint Eustatius and Saba", "Países Baixos Caribenhos, Caraíbas Neerlandesas")
                 .gsub("Bosnia and Herzegovina", "Bósnia e Herzegovina")
                 .gsub("Botswana", "Botswana")
                 .gsub("Bouvet Island", "Ilha Bouvet")
                 .gsub("British Indian Ocean Territory", "Território Britânico do Oceano Índico")
                 .gsub("British Virgin Islands", "Ilhas Virgens Britânicas")
                 .gsub("Brunei Darussalam", "Brunei")
                 .gsub("Burkina Faso", "Burkina Faso")
                 .gsub("Burma", "Birmânia")
                 .gsub("Burundi", "Burundi")
                 .gsub("Cambodia", "Camboja")
                 .gsub("Cameroon", "Camarões")
                 .gsub("Cape Verde", "Cabo Verde")
                 .gsub("Cayman Islands", "Ilhas Cayman")
                 .gsub("Central African Republic", "República Centro-Africana")
                 .gsub("Chad", "Chade")
                 .gsub("Chile", "Chile")
                 .gsub("Christmas Island", "Ilha do Natal")
                 .gsub("Cocos (Keeling) Islands", "Ilhas Cocos (Keeling)")
                 .gsub("Comoros", "Comores")
                 .gsub("Congo", "Congo")
                 .gsub("Cook Islands", "Ilhas Cook")
                 .gsub("Côte d'Ivoire", "Costa do Marfim")
                 .gsub("Croatia", "Croácia")
                 .gsub("Cuba", "Cuba")
                 .gsub("Cyprus", "Chipre")
                 .gsub("Czechoslovakia", "Checoslováquia")
                 .gsub("Democratic Republic of the Congo", "República Democrática do Congo")
                 .gsub("Djibouti", "Djibouti")
                 .gsub("Dominica", "Dominica")
                 .gsub("Dominican Republic", "República Dominicana")
                 .gsub("East Germany", "Alemanha Oriental")
                 .gsub("Ecuador", "Equador")
                 .gsub("Egypt", "Egito")
                 .gsub("El Salvador", "El Salvador")
                 .gsub("Equatorial Guinea", "Guiné Equatorial")
                 .gsub("Eritrea", "Eritreia")
                 .gsub("Estonia", "Estônia")
                 .gsub("Ethiopia", "Etiópia")
                 .gsub("Falkland Islands", "Ilhas Malvinas")
                 .gsub("Faroe Islands", "Ilhas Feroe")
                 .gsub("Federal Republic of Yugoslavia", "República Socialista Federativa da Iugoslávia")
                 .gsub("Federated States of Micronesia", "Estados Federados da Micronésia")
                 .gsub("Fiji", "Fiji")
                 .gsub("French Guiana", "Guiana Francesa")
                 .gsub("French Polynesia", "Polinésia Francesa")
                 .gsub("French Southern Territories", "Terras Austrais e Antárticas Francesas")
                 .gsub("Gabon", "Gabão")
                 .gsub("Gambia", "Gâmbia")
                 .gsub("Georgia", "Geórgia")
                 .gsub("Ghana", "Gana")
                 .gsub("Gibraltar", "Gibraltar")
                 .gsub("Greenland", "Groenlândia")
                 .gsub("Grenada", "Granada")
                 .gsub("Guadeloupe", "Guadalupe")
                 .gsub("Guam", "Guam")
                 .gsub("Guatemala", "Guatemala")
                 .gsub("Guernsey", "Guernsey")
                 .gsub("Guinea", "Guiné")
                 .gsub("Guinea-Bissau", "Guiné-Bissau")
                 .gsub("Guyana", "Guiana")
                 .gsub("Haiti", "Haiti")
                 .gsub("Heard Island and McDonald Islands", "Ilha Heard e Ilhas McDonald")
                 .gsub("Holy See (Vatican City State)", "Santa Sé (Cidade do Vaticano)")
                 .gsub("Honduras", "Honduras")
                 .gsub("Indonesia", "Indonésia")
                 .gsub("Iraq", "Iraque")
                 .gsub("Isle of Man", "Ilha de Man")
                 .gsub("Israel", "Israel")
                 .gsub("Jamaica", "Jamaica")
                 .gsub("Jersey", "Jersey")
                 .gsub("Jordan", "Jordânia")
                 .gsub("Kazakhstan", "Cazaquistão")
                 .gsub("Kenya", "Quênia")
                 .gsub("Kiribati", "Kiribati")
                 .gsub("Korea", "Coreia")
                 .gsub("Kosovo", "Kosovo")
                 .gsub("Kuwait", "Kuwait")
                 .gsub("Kyrgyzstan", "Quirguistão")
                 .gsub("Laos", "Laos")
                 .gsub("Latvia", "Letônia")
                 .gsub("Lebanon", "Líbano")
                 .gsub("Lesotho", "Lesoto")
                 .gsub("Liberia", "Libéria")
                 .gsub("Libya", "Líbia")
                 .gsub("Liechtenstein", "Liechtenstein")
                 .gsub("Lithuania", "Lituânia")
                 .gsub("Luxembourg", "Luxemburgo")
                 .gsub("Macao", "Macau")
                 .gsub("Madagascar", "Madagascar")
                 .gsub("Malawi", "Malawi")
                 .gsub("Maldives", "Maldivas")
                 .gsub("Mali", "Mali")
                 .gsub("Malta", "Malta")
                 .gsub("Marshall Islands", "Ilhas Marshall")
                 .gsub("Martinique", "Martinica")
                 .gsub("Mauritania", "Mauritânia")
                 .gsub("Mauritius", "Maurícia")
                 .gsub("Mayotte", "Maiote")
                 .gsub("Moldova", "Moldávia")
                 .gsub("Monaco", "Principado de Mônaco")
                 .gsub("Mongolia", "Mongólia")
                 .gsub("Montenegro", "Montenegro")
                 .gsub("Montserrat", "Montserrat")
                 .gsub("Morocco", "Marrocos")
                 .gsub("Mozambique", "Moçambique")
                 .gsub("Myanmar", "Myanmar (Birmânia)")
                 .gsub("Namibia", "Namíbia")
                 .gsub("Nauru", "Nauru")
                 .gsub("Nepal", "Nepal")
                 .gsub("Netherlands Antilles", "Antilhas Holandesas")
                 .gsub("New Caledonia", "Nova Caledônia")
                 .gsub("Nicaragua", "Nicarágua")
                 .gsub("Niger", "Níger")
                 .gsub("Nigeria", "Nigéria")
                 .gsub("Niue", "Niue")
                 .gsub("Norfolk Island", "Ilha Norfolk")
                 .gsub("North Korea", "Coreia do Norte")
                 .gsub("North Vietnam", "Vietnã do Norte")
                 .gsub("Northern Mariana Islands", "Ilhas Marianas Setentrionais")
                 .gsub("Norway", "Noruega")
                 .gsub("Oman", "Omã")
                 .gsub("Palau", "Palau")
                 .gsub("Palestine", "Palestina")
                 .gsub("Palestinian Territory", "Territórios Palestinianos")
                 .gsub("Panama", "Panamá")
                 .gsub("Papua New Guinea", "Papua Nova Guiné")
                 .gsub("Paraguay", "Paraguai")
                 .gsub("Peru", "Peru")
                 .gsub("Philippines", "Filipinas")
                 .gsub("Pitcairn", "Ilhas Picárnia")
                 .gsub("Puerto Rico", "Porto Rico")
                 .gsub("Qatar", "Catar")
                 .gsub("Republic of Macedonia", "República da Macedônia")
                 .gsub("Réunion", "Reunião")
                 .gsub("Rwanda", "Ruanda")
                 .gsub("Saint Barthélemy", "Coletividade de São Bartolomeu")
                 .gsub("Saint Helena", "Santa Helena, Ascensão e Tristão da Cunha")
                 .gsub("Saint Kitts and Nevis", "São Cristóvão e Nevis")
                 .gsub("Saint Lucia", "Santa Lúcia")
                 .gsub("Saint Martin (French part)", "Ilha de São Martinho")
                 .gsub("Saint Pierre and Miquelon", "São Pedro e Miquelon")
                 .gsub("Saint Vincent and the Grenadines", "São Vicente e Granadinas")
                 .gsub("Samoa", "Samoa")
                 .gsub("San Marino", "San Marino")
                 .gsub("Sao Tome and Principe", "São Tomé e Príncipe")
                 .gsub("Saudi Arabia", "Arábia Saudita")
                 .gsub("Senegal", "Senegal")
                 .gsub("Serbia", "Sérvia")
                 .gsub("Serbia and Montenegro", "Sérvia e Montenegro")
                 .gsub("Seychelles", "Seicheles")
                 .gsub("Siam", "Tailândia")
                 .gsub("Sierra Leone", "Serra Leoa")
                 .gsub("Slovakia", "Eslováquia")
                 .gsub("Slovenia", "Eslovênia")
                 .gsub("Solomon Islands", "Ilhas Salomão")
                 .gsub("Somalia", "Somália")
                 .gsub("South Georgia and the South Sandwich Islands", "Ilhas Geórgias do Sul e Sandwich do Sul")
                 .gsub("South Korea", "Coreia do Sul")
                 .gsub("Soviet Union", "União Soviética")
                 .gsub("Sri Lanka", "Sri Lanka")
                 .gsub("Sudan", "Sudão")
                 .gsub("Suriname", "Suriname")
                 .gsub("Svalbard and Jan Mayen", "Svalbard e Jan Mayen")
                 .gsub("Swaziland", "Suazilândia")
                 .gsub("Syria", "Síria")
                 .gsub("Taiwan", "Taiwan")
                 .gsub("Tajikistan", "Tajiquistão")
                 .gsub("Tanzania", "Tanzânia")
                 .gsub("Timor-Leste", "Timor-Leste")
                 .gsub("Togo", "Togo")
                 .gsub("Tokelau", "Tokelau")
                 .gsub("Tonga", "Tonga")
                 .gsub("Trinidad and Tobago", "Trindade e Tobago")
                 .gsub("Tunisia", "Tunísia")
                 .gsub("Turkey", "Turquia")
                 .gsub("Turkmenistan", "Turcomenistão ")
                 .gsub("Turks and Caicos Islands", "Ilhas Turcas e Caicos")
                 .gsub("Tuvalu", "Tuvalu")
                 .gsub("U.S. Virgin Islands", "Ilhas Virgens Americanas")
                 .gsub("Uganda", "Uganda")
                 .gsub("Ukraine", "Ucrânia")
                 .gsub("United Arab Emirates", "Emirados Árabes Unidos")
                 .gsub("United States Minor Outlying Islands", "Ilhas Menores Distantes dos Estados Unidos")
                 .gsub("Uruguay", "Uruguai")
                 .gsub("Uzbekistan", "Uzbequistão")
                 .gsub("Vanuatu", "Vanuatu")
                 .gsub("Venezuela", "Venezuela")
                 .gsub("Vietnam", "Vietnã")
                 .gsub("Wallis and Futuna", "Wallis e Futuna")
                 .gsub("West Germany", "Alemanha Ocidental")
                 .gsub("Western Sahara", "Saara Ocidental")
                 .gsub("Yemen", "Iêmen")
                 .gsub("Yugoslavia", "Iugoslávia")
                 .gsub("Zaire", "Zaire (República Democrática do Congo)")
                 .gsub("Zambia", "Zâmbia")
                 .gsub("Zimbabwe", "Zimbabwe")

      self.countries = countries
      save(validate: false) if countries
      countries
    end

    def title_str
      return title unless title.blank?
      original_title_str
    end

    def length_str
      length = self.length
      return "" unless length
      length = begin
                 Integer(length.gsub("min", "").strip)
               rescue
                 0
               end
      hours = 0
      while length >= 60
        length -= 60
        hours += 1
      end

      return "#{hours}h" if length == 0 && hours > 0
      return "#{length}min" if length > 0 && hours == 0
      return "#{hours}h#{length}min" if length > 0 && hours > 0
      ""
    end

    def genders_str
      %w[Ação Aventura].to_sentence
    end

    def first_actors_str
      actors = professionals.where(set_function: SetFunction.find_by(name: 'Elenco')).first(3)
      actors.map(&:name).to_sentence
    end

    def actors_str
      actors = professionals.where(set_function: SetFunction.find_by(name: 'Elenco'))
      actors.map(&:name).to_sentence
    end

    def directors_str
      directors = professionals.where(set_function: SetFunction.find_by(name: 'Direção'))
      directors.map(&:name).to_sentence
    end

    def first_actors
      actors = professionals.where(set_function: SetFunction.find_by(name: 'Elenco')).first(3)
      actors.map(&:name).to_sentence
    end

    def actors
      filmable_professionals.where(set_function: SetFunction.find_by(name: 'Elenco'))
    end

    def directors
      filmable_professionals.where(set_function: SetFunction.find_by(name: 'Direção'))
    end

    def writers
      filmable_professionals.where(set_function: SetFunction.find_by(name: 'Roteiro'))
    end

    def release_str
      I18n.l(release, format: :long_date) if release.is_a?(Date)
    end

    def brazilian_release_str
      I18n.l(brazilian_release, format: :long_date) if brazilian_release.is_a?(Date)
    end

    # Critics

    def ciner_official_critic
      return unless critics.any?
      critics.ciner_official_critic
    end

    def ciner_rating_user
      "João Bidu"
    end

    def users_rating
      5.0
    end

    def users_rating_count
      1000
    end

    def incinerator
      return unless critics.any?
      critics.find_by(quick: true)
    end
  end

  def self.filmables_by_type(type)
    return unless type.present?
    Object.const_get(type).first(20)
  end

  def self.localized_filmable_types
    [['Filme', Movie], ['Série', Serie]]
  end

  def self.localized_years
    limit_year = (DateTime.now + 5.years).year
    years = []
    (1895..limit_year).each { |year| years << year }
    years
  end

  def self.playing_soon
    where(playing_soon: true).order(brazilian_release: :asc)
  end

  def self.available_netflix
    where(available_netflix: true).order(brazilian_release: :desc)
  end

  def self.available_amazon
    where(available_amazon: true).order(brazilian_release: :desc)
  end
end
