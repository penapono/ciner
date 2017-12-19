# frozen_string_literal: true

class UserFilmableRating < ActiveRecord::Base
  # Prevents deleting
  acts_as_paranoid

  # Associations
  belongs_to :user
  belongs_to :filmable, polymorphic: true

  # Validations
  validates :rating,
            :user_id,
            :filmable_type,
            :filmable_id,
            presence: true

  # Delegations
  after_save :update_critic

  # Callbacks

  def update_year
    true
  end
end
