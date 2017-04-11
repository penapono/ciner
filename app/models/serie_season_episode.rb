# frozen_string_literal: true

class SerieSeasonEpisode < ActiveRecord::Base
  # Associations
  belongs_to :serie
  belongs_to :serie_season

  # Validations
  validates :serie,
            :serie_season,
            presence: true
end
