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
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :broadcast_broadcastables, dependent: :destroy

  # Validations
  validates :title,
            :content,
            :user,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true

  # Nested
  accepts_nested_attributes_for :broadcast_broadcastables,
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

  # Methods

  def spoiler_str
    return Broadcast.human_attribute_name("spoiler.has_spoiler") if spoiler
    Broadcast.human_attribute_name("spoiler.spoiler_free")
  end

  def created_at_str
    I18n.l(created_at, format: :long) if created_at.is_a?(Time)
  end

  def content_str
    ActionView::Base.full_sanitizer.sanitize(content).truncate(155)
  end

  def collapsed_content
    content_str.truncate(50)
  end

  def collapsed_title
    title.truncate(140)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection

    result
  end
end
