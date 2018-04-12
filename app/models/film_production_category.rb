# frozen_string_literal: true

class FilmProductionCategory < ActiveRecord::Base
  include Searchables::FilmProductionCategory

  # Validations
  validates :name,
            presence: true

  # Scope
  default_scope { order(name: :asc) }

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
