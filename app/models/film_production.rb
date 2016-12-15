class FilmProduction < ActiveRecord::Base
  # Associations
  belongs_to :country
  belongs_to :age_range
  belongs_to :film_production_category

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
