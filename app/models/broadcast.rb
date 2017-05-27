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
    two_last_created = last_created.all_but(broadcasts).first(2)
    two_last_created.each { |q| broadcasts << q }

    broadcasts.first(10)
  end

  def self.all_creation
    broadcasts = []

    featured.first(2).each { |q| broadcasts << q }
    two_last_created = last_created.all_but(broadcasts).first(2)
    two_last_created.each { |q| broadcasts << q }

    Broadcast.where(id: broadcasts.pluck(:id))
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

  def self.by_broadcastable_type(broadcastable_type)
    broadcast_ids = BroadcastBroadcastable.where(broadcastable_type: broadcastable_type).pluck(:broadcast_id)
    where(id: broadcast_ids)
  end

  def self.by_year(year)
    broadcast_ids = []
    BroadcastBroadcastable.each do |bb|
      broadcast_ids << bb.broadcast_id if bb.filmable_year == year
    end

    where(id: brodcast_ids)
  end

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_broadcastable_type(params[:broadcastable_type]) unless params[:broadcastable_type].blank?
    result = result.by_year(params[:year]) unless params[:year].blank?

    result
  end
end
