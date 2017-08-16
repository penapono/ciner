# frozen_string_literal: true

class Broadcast < ActiveRecord::Base
  include Searchables::Broadcast
  include Reactionable
  include CommentManageable
  include Visitable

  acts_as_votable

  # Uploaders
  mount_uploader :cover, BroadcastCoverUploader

  # Associations
  has_many :comments, as: :commentable
  has_many :broadcast_images, dependent: :destroy
  has_many :broadcast_professionals, dependent: :destroy
  has_many :broadcast_broadcastables, dependent: :destroy

  # Validations
  validates :title,
            :subtitle,
            :content,
            :broadcast_date,
            presence: true

  # Nested
  accepts_nested_attributes_for :broadcast_broadcastables,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :broadcast_images,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :broadcast_professionals,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Aliases
  alias_attribute :title_str, :title

  # Scopes

  def self.more_commented
    order(comments_count: :desc)
  end

  def self.last_created
    order(created_at: :desc)
  end

  def self.featured
    where(featured: true)
  end

  def self.all_but(objects)
    ids = []

    objects.each { |q| ids << q.id }
    where.not(id: ids)
  end

  def self.top_broadcasts
    broadcasts = []

    featured.first(2).each { |q| broadcasts << q }
    some_last_created = last_created.all_but(broadcasts).first(10)
    some_last_created.each { |q| broadcasts << q }

    broadcasts.first(10)
  end

  def self.all_creation
    broadcasts = []

    featured.first(2).each { |q| broadcasts << q }
    two_last_created = last_created.all_but(broadcasts)
    two_last_created.each { |q| broadcasts << q }

    Broadcast.where(id: broadcasts.pluck(:id)).order(featured: :desc)
  end

  # Methods

  def date_str
    return I18n.l(broadcast_date, format: :simpledate) unless broadcast_date.blank?
    ""
  end

  def spoiler_str
    return Broadcast.human_attribute_name("spoiler.has_spoiler") if spoiler
    Broadcast.human_attribute_name("spoiler.spoiler_free")
  end

  def created_at_str
    I18n.l(created_at, format: :long) if created_at.is_a?(Time)
  end

  def content_str
    ActionView::Base.full_sanitizer.sanitize(content)
  end

  def collapsed_content
    content_str.truncate(50)
  end

  def collapsed_title
    title.truncate(140)
  end

  # Filter

  def self.by_broadcast_content_type(broadcast_content_type)
    return where(movie_content: true) if broadcast_content_type == "movie"

    return where(serie_content: true) if broadcast_content_type == "serie"

    return where(celebrity_content: true) if broadcast_content_type == "celebrities"
    all
  end

  def self.by_date(date)
    where(broadcast_date: Date.parse(date))
  end

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_broadcast_content_type(params[:broadcast_content_type]) unless params[:broadcast_content_type].blank?
    result = result.by_date(params[:date]) unless params[:date].blank?

    result
  end
end
