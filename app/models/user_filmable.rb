# frozen_string_literal: true

class UserFilmable < ActiveRecord::Base
  # Validations
  validates :user,
            :filmable_id,
            :filmable_type,
            :action,
            presence: true

  # Enums
  enum action: { watched: 1, want_to_see: 2, collection: 3, favorite: 4, like: 5 }

  # Associations
  belongs_to :user
  belongs_to :filmable, polymorphic: true
end
