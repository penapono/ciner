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

  def self.localized_filmable_types
    [['Filme', Movie],['Série', Serie]]
  end

  def self.localized_years
    years = []
    (1930..DateTime.now.year).each { |year| years << year }
    years
  end
end
