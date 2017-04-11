# frozen_string_literal: true

class SerieSeason < ActiveRecord::Base
  # Associations
  belongs_to :serie

  has_many :serie_season_episodes

  # Validations
  validates :serie,
            presence: true
end
