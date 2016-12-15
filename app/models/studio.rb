class Studio < ActiveRecord::Base
  # Associations
  belongs_to :country

  # Validations
  validates :name,
            presence: true
end
