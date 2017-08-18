# frozen_string_literal: true

class CurriculumJob < ActiveRecord::Base
  belongs_to :curriculum

  # Validations
  validates :description,
            presence: true
end
