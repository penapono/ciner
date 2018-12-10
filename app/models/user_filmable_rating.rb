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

  def update_critic
    critic =
      Critic
      .where(
        user_id: user_id,
        filmable: filmable
      )
      .first
    return unless critic && critic.rating != rating

    critic.rating = rating
    critic.save
  end
end
