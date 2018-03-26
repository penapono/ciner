# frozen_string_literal: true

class SetFunction < ActiveRecord::Base
  include Searchables::SetFunction

  # Associations
  belongs_to :user

  # Validations
  validates :name,
            presence: true

  # Scope
  default_scope { order(name: :asc) }

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
