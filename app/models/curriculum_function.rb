# frozen_string_literal: true

class CurriculumFunction < ActiveRecord::Base
  include Searchables::CurriculumFunction

  # Validations
  validates :name,
            presence: true

  validates :name,
            uniqueness: true, case_sensitive: false

  # Scope
  default_scope { order(name: :asc) }

  # Aliases
  alias_attribute :text, :general

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
