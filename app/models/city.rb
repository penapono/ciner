# frozen_string_literal: true

class City < ActiveRecord::Base
  # Associations
  belongs_to :state
  has_many :user

  # Validations
  validates :name,
            :state,
            presence: true

  validates_uniqueness_of :name, scope: :state_id

  # Delegations
  delegate :name, to: :state, allow_nil: true, prefix: true

  default_scope { order(name: :asc) }

  def self.by_state_acronym(acronym)
    State.find_by(acronym: acronym).cities
  end
end
