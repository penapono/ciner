# frozen_string_literal: true
module FilmProfitable
  extend ActiveSupport::Concern

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
      return "Livre" if omdb_rated == "G"

      return "10 anos" if omdb_rated == "PG"

      return "14 anos" if omdb_rated == "PG-13"

      return "16 anos" if omdb_rated == "R"

      "18 anos" # if omdb_rated = "NC-17"
    end

    def title_str
      return title unless title.blank?
      original_title
    end

    def genders_str
      %w(Ação Aventura).to_sentence
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
