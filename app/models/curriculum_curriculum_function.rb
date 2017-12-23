# frozen_string_literal: true

class CurriculumCurriculumFunction < ActiveRecord::Base
  belongs_to :curriculum
  belongs_to :curriculum_function

  # Validations
  validates :curriculum,
            presence: true
end
