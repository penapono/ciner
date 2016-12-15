class FilmProductionCategory < ActiveRecord::Base
  # Validations
  validates :name,
            presence: true
end
