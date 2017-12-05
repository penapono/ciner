# frozen_string_literal: true

class FilmableProfessional < ActiveRecord::Base
  acts_as_paranoid

  # Associations
  belongs_to :filmable, polymorphic: true

  belongs_to :professional
  belongs_to :set_function

  # Validations
  validates :professional,
            :set_function,
            presence: true
end
