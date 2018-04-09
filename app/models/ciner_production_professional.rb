# frozen_string_literal: true

class CinerProductionProfessional < ActiveRecord::Base
  acts_as_paranoid

  # Associations
  belongs_to :ciner_production
  belongs_to :user
  belongs_to :curriculum_function

  # Validations
  validates :ciner_production,
            :user,
            :curriculum_function,
            presence: true

  def professional
    user
  end
end
