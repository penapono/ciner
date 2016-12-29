# frozen_string_literal: true
class AgeRange < ActiveRecord::Base
  include Searchables::AgeRange

  # Validations
  validates :name,
            :age,
            presence: true

  def self.filter_by(collection, params)
    collection
  end
end
