# frozen_string_literal: true

class Trophy < ActiveRecord::Base
  # Validations
  validates :name,
            :description,
            :level,
            presence: true

  enum level: { top: 1, leading: 2, supporting: 3, figurant: 4 }

  default_scope { order(position: :asc) }
end
