class City < ActiveRecord::Base
  # Associations
  belongs_to :state

  # Validations
  validates :name,
            :state,
            presence: true

  validates_uniqueness_of :name, scope: :state_id

  # Delegations
  delegate :name, to: :state, allow_nil: true, prefix: true
end
