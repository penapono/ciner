class AgeRange < ActiveRecord::Base
  # Validations
  validates :name,
            :age,
            presence: true
end
