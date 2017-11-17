# frozen_string_literal: true

class TrendingTrailer < ActiveRecord::Base
  # Validations
  validates :title,
            :trailer,
            :filmable_type,
            :filmable_id,
            presence: true

  # Associations
  belongs_to :filmable, polymorphic: true

  # Scope
  default_scope { order(created_at: :desc) }
end
