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
      " - "
    end

    def writers_pt
      return "Não disponível" unless omdb_writers
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
                  .gsub("(play)", "(peça de teatro)")
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
    end

    def countries_str
      countries = self.countries
      return "Não disponível" unless countries

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
                 .gsub("United Kingdom", "Reino Unido")
                 .gsub("United States", "EUA")
                 .gsub("USA", "EUA")

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
      return "Não disponível" unless length
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
      " - "
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
end
