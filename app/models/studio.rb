# frozen_string_literal: true
class Studio < ActiveRecord::Base
  # Associations
  belongs_to :country

  # Validations
  validates :name,
            presence: true

  # Delegations
  delegate :name, to: :country, allow_nil: true, prefix: true
end
