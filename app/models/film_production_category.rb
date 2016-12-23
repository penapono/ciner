# frozen_string_literal: true
class FilmProductionCategory < ActiveRecord::Base
  # Validations
  validates :name,
            presence: true
end
