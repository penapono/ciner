class SetFunction < ActiveRecord::Base
  # Associations
  belongs_to :user

  # Validations
  validates :name,
            presence: true

  validates :name,
            uniqueness: true, case_sensitive: false
end
