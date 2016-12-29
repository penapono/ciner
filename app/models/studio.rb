# frozen_string_literal: true
class Studio < ActiveRecord::Base
  # Associations
  belongs_to :city
  belongs_to :state
  belongs_to :country

  # Validations
  validates :name,
            presence: true

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :state, allow_nil: true, prefix: true
  delegate :name, to: :country, allow_nil: true, prefix: true
end
