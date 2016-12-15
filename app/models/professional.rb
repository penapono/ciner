class Professional < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :country
  belongs_to :set_function

  # Validations
  validates :name,
            :set_function,
            presence: true
end
