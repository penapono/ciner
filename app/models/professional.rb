class Professional < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :country
  belongs_to :set_function

  # Validations
  validates :name,
            :set_function,
            presence: true

  # Delegations
  delegate :name, to: :country, allow_nil: true, prefix: true
  delegate :name, to: :set_function, allow_nil: true, prefix: true
end
