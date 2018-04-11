# frozen_string_literal: true

class CinerProductionVideo < ActiveRecord::Base
  # Associations
  belongs_to :ciner_production

  # Validations
  validates :video,
            presence: true

  # Scope
  default_scope { order(season: :asc, episode: :asc) }

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
