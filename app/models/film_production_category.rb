# frozen_string_literal: true

class FilmProductionCategory < ActiveRecord::Base
  include Searchables::FilmProductionCategory

  # Validations
  validates :name,
            presence: true

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
