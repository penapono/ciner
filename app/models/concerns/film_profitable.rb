# frozen_string_literal: true
module FilmProfitable
  extend ActiveSupport::Concern

  included do
    def title_str
      return title unless title.blank?
      original_title
    end

    def genders_str
      ["Ação", "Aventura"].to_sentence
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
