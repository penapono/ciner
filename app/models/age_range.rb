# frozen_string_literal: true
class AgeRange < ActiveRecord::Base
  # Validations
  validates :name,
            :age,
            presence: true
end
