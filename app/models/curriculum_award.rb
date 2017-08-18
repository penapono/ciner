# frozen_string_literal: true

class CurriculumAward < ActiveRecord::Base
  belongs_to :curriculum

  # Validations
  validates :category,
            :title,
            presence: true
end
