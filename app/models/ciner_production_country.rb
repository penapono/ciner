# frozen_string_literal: true

class CinerProductionCountry < ActiveRecord::Base
  # Associations
  belongs_to :ciner_production
  belongs_to :country

  # Validations
  validates :ciner_production,
            :country,
            presence: true

  # Scope

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
