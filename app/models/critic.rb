# frozen_string_literal: true

class Critic < ActiveRecord::Base
  include Searchables::Critic
  include Reactionable

  # Prevents deleting
  acts_as_paranoid

  acts_as_votable

  # Enums
  enum status: { pending: 1, approved: 2, reproved: 3 }
  enum origin: { ciner_critic: 1, user_critic: 2 }

  # Associations
  belongs_to :user

  belongs_to :filmable, polymorphic: true

  # Validations
  validates :content,
            :user_id,
            :filmable_type,
            :filmable_id,
            :rating,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :nickname, to: :user, allow_nil: true, prefix: true
  delegate :title_str, to: :filmable, allow_nil: true, prefix: true
  delegate :original_title, to: :filmable, allow_nil: true, prefix: true
  delegate :cover, to: :filmable, allow_nil: true, prefix: true

  # Callbacks
  before_save :update_year
  after_save :update_user_filmable_rating
  before_destroy :delete_user_filmable_rating

  # Aliases
  alias_attribute :title_str, :name
  alias_attribute :cover, :filmable_cover

  # Scopes

  def self.highlight
    first_critic
  end

  def self.home
    [first_critic, second_critic]
  end

  def self.first_critic
    first = where(origin: 1, status: 2, featured: true).order(created_at: :desc).first
    first ||= where(origin: 1, status: 2).order(created_at: :desc).first
    first ||= where(status: 2, origin: 2).order(created_at: :desc).first
    first
  end

  def self.second_critic
    first = first_critic
    second = where(status: 2, origin: 2).where.not(id: first.id).order(created_at: :desc).first if first
    second ||= where(status: 2).where.not(id: first.id).order(created_at: :desc).first if first
    second ||= where(status: 2, origin: 2).order(created_at: :desc).first
    return nil if second == first
    second
  end

  def self.only_two
    [first_critic, second_critic]
  end

  def self.all_but(denied_critics)
    filtered_critics = where(origin: 1)
    return filtered_critics if denied_critics.blank? || denied_critics.first.blank?
    filtered_critics.where.not(id: denied_critics.pluck(:id))
  end

  def self.ordered_by_status
    order(status: :asc)
  end

  def self.ciner_official_critic
    where(user_id: User.admin.pluck(:id)).average(:rating)
  end

  # Methods

  def date_str
    I18n.l(created_at, format: :shorter)
  end

  def collapsed_content
    ActionView::Base.full_sanitizer.sanitize(content).truncate(185)
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
    self.filmable_release_year = filmable.filmable_year if filmable.brazilian_release
  end

  def update_user_filmable_rating
    user_filmable_rating =
      UserFilmableRating
      .find_or_initialize_by(
        user_id: user_id,
        filmable: filmable
      )
    return if user_filmable_rating.rating == rating
    user_filmable_rating.rating = rating
    user_filmable_rating.save
  end

  def destroy_user_filmable_rating
    user_filmable_rating =
      UserFilmableRating
      .find_by(
        user_id: user_id,
        filmable: filmable
      )
      user_filmable_rating.destroy
  end
end
