# frozen_string_literal: true
class Critic < ActiveRecord::Base
  include Searchables::Critic

  acts_as_votable

  # Enums
  enum status: { pending: 1, approved: 2, reproved: 3 }
  enum origin: { ciner_critic: 1, user_critic: 2 }

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
    ActionView::Base.full_sanitizer.sanitize(content).truncate(155)
  end

  def name
    ActionView::Base.full_sanitizer.sanitize(content).truncate(30)
  end

  def status_str
    Critic.human_attribute_name("status.#{status}")
  end

  def origin_str
    Critic.human_attribute_name("origin.#{origin}")
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_filmable_type(params[:filmable_type]) if params[:filmable_type].present?
    result = result.by_filmable_id(params[:filmable_id]) if params[:filmable_id].present?
    result = result.by_year(params[:year]) if params[:year].present?
    result = result.by_status(params[:status]) if params[:status].present?
    result = result.by_origin(params[:origin]) if params[:origin].present?

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

  def self.ciner_official_critic
    find_by(ciner_critic: true)
  end

  def self.by_status(status)
    where(status: status)
  end

  def self.localized_statuses
    statuses.map { |k, w| [human_attribute_name("status.#{k}"), w]}
  end

  def self.by_origin(origin)
    where(origin: origin)
  end

  def self.localized_origins
    origins.map { |k, w| [human_attribute_name("origin.#{k}"), w]}
  end

  # Callbacks

  def update_year
    return unless filmable
    self.filmable_release_year = filmable.release.year
  end
end
