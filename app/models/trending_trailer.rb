# frozen_string_literal: true

class TrendingTrailer < ActiveRecord::Base
  # Validations
  validates :title,
            :trailer,
            presence: true

  # Scope
  default_scope { order(created_at: :desc) }
end
