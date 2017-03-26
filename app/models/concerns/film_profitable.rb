# frozen_string_literal: true
module FilmProfitable
  extend ActiveSupport::Concern

  API_KEY   = "8802a6c6583ac6edc44bea8d577baa97"
  BASE_URL  = "https://api.themoviedb.org/3"
  LANGUAGE  = "language=pt-BR"

  included do
    def is_serie?(object)
      object.class.to_s == "Serie"
    end

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
      return unless omdb_rated
      omdb_rated + " anos"
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
      # collaborator on screenplay
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

      return "#{hours}h#{length}min" if length > 0
      "#{hours}h"
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
