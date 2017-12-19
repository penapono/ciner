# frozen_string_literal: true

class SerieDuplicate < ActiveRecord::Base
  # Validations
  validates :title,
            :count,
            presence: true
end
