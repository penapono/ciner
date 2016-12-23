# frozen_string_literal: true
class Country < ActiveRecord::Base
  # Associations
  has_many :states

  # Validations
  validates :acronym,
            :name,
            presence: true

  validates_uniqueness_of :name
end
