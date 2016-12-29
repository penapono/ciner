# frozen_string_literal: true
class SetFunction < ActiveRecord::Base
  include Searchables::SetFunction

  # Associations
  belongs_to :user

  # Validations
  validates :name,
            presence: true

  validates :name,
            uniqueness: true, case_sensitive: false

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
