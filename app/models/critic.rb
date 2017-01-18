# frozen_string_literal: true
class Critic < ActiveRecord::Base
  include Searchables::Critic

  # Associations
  belongs_to :user

  belongs_to :filmable, polymorphic: true

  # Validations
  validates :name,
            :content,
            :user,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection

    result
  end
end
