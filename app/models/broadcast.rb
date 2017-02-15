# frozen_string_literal: true
class Broadcast < ActiveRecord::Base
  include Searchables::Broadcast
  include Reactionable
  include CommentManageable
  include Visitable

  acts_as_votable

  # Associations
  belongs_to :user

  has_many :comments, as: :commentable

  # Validations
  validates :title,
            :content,
            :user,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true

  # Scopes

  def self.more_commented
    order(comments_count: :desc)
  end

  def self.last_created
    order(created_at: :desc)
  end

  def self.all_but(objects)
    ids = []

    objects.each { |q| ids << q.id }
    where.not(id: ids)
  end

  def self.top_broadcasts
    broadcasts = []

    more_commented.first(2).each { |q| broadcasts << q }
    two_last_created = last_created.all_but(broadcasts).first(2)
    two_last_created.each { |q| broadcasts << q }

    broadcasts
  end

  # Methods

  def spoiler_str
    return Broadcast.human_attribute_name("spoiler.has_spoiler") if spoiler
    Broadcast.human_attribute_name("spoiler.spoiler_free")
  end

  def created_at_str
    I18n.l(created_at, format: :long) if created_at.is_a?(Time)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection

    result
  end
end
