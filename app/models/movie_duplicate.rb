# frozen_string_literal: true

class MovieDuplicate < ActiveRecord::Base
  # Validations
  validates :title,
            :count,
            presence: true
end
