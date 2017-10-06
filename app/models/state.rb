# frozen_string_literal: true

class State < ActiveRecord::Base
  # Associations
  belongs_to :country
  has_many :cities
  has_many :users

  # Validations
  validates :acronym,
            :name,
            presence: true

  validates_uniqueness_of :name, scope: :country_id

  # Delegations
  delegate :name, to: :country, allow_nil: true, prefix: true
end
