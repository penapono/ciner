# frozen_string_literal: true
module FilmProfitable
  extend ActiveSupport::Concern

  included do
    def title_str
      return title unless title.blank?
      original_title
    end

    def subtitle_str
      "Não informado"
    end

    def genders_str
      "Não informado"
    end

    def directors_str
      "Não informado"
    end

    # def actors
    #   ["Não informado 1", "Não Informado 2", "Não informado 3"].to_sentence
    # end
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
