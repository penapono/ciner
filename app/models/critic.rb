# frozen_string_literal: true
class Critic < ActiveRecord::Base
  include Searchables::Critic

  # Associations
  belongs_to :user

  belongs_to :filmable, polymorphic: true

  # Validations
  validates :content,
            :user,
            :filmable_type,
            :filmable_id,
            :rating,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :title_str, to: :filmable, allow_nil: true, prefix: true
  delegate :original_title, to: :filmable, allow_nil: true, prefix: true
  delegate :cover, to: :filmable, allow_nil: true, prefix: true

  # Callbacks
  before_save :update_year

  # Methods
  def collapsed_content
    content.truncate(155)
  end

  def name
    content.truncate(50)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_filmable_type(params[:filmable_type]) if params[:filmable_type].present?
    result = result.by_filmable_id(params[:filmable_id]) if params[:filmable_id].present?
    result = result.by_year(params[:year]) if params[:year].present?

    result
  end

  def self.by_filmable_type(filmable_type)
    where(filmable_type: filmable_type)
  end

  def self.by_filmable_id(filmable_id)
    where(filmable_id: filmable_id)
  end

  def self.by_year(year)
    where(filmable_release_year: year)
  end

  def update_year
    return unless filmable
    self.filmable_release_year = filmable.release.year
  end
end
