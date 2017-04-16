# frozen_string_literal: true

class Critic < ActiveRecord::Base
  include Searchables::Critic
  include Reactionable

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

  # Scopes

  def self.highlight
    first_critic
  end

  def self.home
    Critic.only_two
  end

  def self.first_critic
    result = where(featured: true, origin: 1, status: 2).first
    return result if result
    where(origin: 1, status: 2).order(created_at: :desc).first
  end

  def self.second_critic
    return if first_critic.blank?
    where.not(id: first_critic.id).order(likes_count: :desc).first
  end

  def self.only_two
    [first_critic, second_critic]
  end

  def self.all_but(denied_critics)
    return if denied_critics.blank? || denied_critics.first.blank?
    where.not(id: denied_critics.pluck(:id))
  end

  def self.ordered_by_status
    order(status: :asc)
  end

  def self.ciner_official_critic
    find_by(origin: 1)
  end

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

  def spoiler_str
    return Critic.human_attribute_name("spoiler.has_spoiler") if spoiler
    Critic.human_attribute_name("spoiler.spoiler_free")
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
    result = result.by_user_id(params[:user_id]) if params[:user_id].present?

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

  def self.by_status(status)
    where(status: status)
  end

  def self.localized_statuses
    statuses.map { |k, w| [human_attribute_name("status.#{k}"), w] }
  end

  def self.localized_detailed_statuses
    statuses.keys.map { |w| [human_attribute_name("status.#{w}"), w] }
  end

  def self.by_origin(origin)
    where(origin: origin)
  end

  def self.localized_origins
    origins.map { |k, w| [human_attribute_name("origin.#{k}"), w] }
  end

  def self.by_user_id(user_id)
    where(user: User.find(user_id))
  end

  # Callbacks

  def update_year
    return unless filmable
    self.filmable_release_year = filmable.release.year
  end
end
