# frozen_string_literal: true
class FilmProduction < ActiveRecord::Base
  # Associations
  belongs_to :country
  belongs_to :age_range

  # Movie
  belongs_to :studio

  # Ciner Movie
  belongs_to :approver, class_name: 'User'
  belongs_to :owner, class_name: 'User'

  # Validations
  validates :original_title,
            :year,
            :length,
            presence: true
end
