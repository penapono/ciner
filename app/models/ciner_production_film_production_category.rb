# frozen_string_literal: true

class CinerProductionFilmProductionCategory < ActiveRecord::Base
  # Associations
  belongs_to :ciner_production
  belongs_to :film_production_category

  # Validations
  validates :ciner_production,
            :film_production_category,
            presence: true

  # Scope

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
