# frozen_string_literal: true

class Comment < ActiveRecord::Base
  include Reactionable

  acts_as_paranoid
  acts_as_votable

  # Enums
  enum status: { pending: 1, approved: 2, reproved: 3 }
  enum origin: { ciner_comment: 1, user_comment: 2 }

  # Associations
  belongs_to :user

  belongs_to :commentable, polymorphic: true

  # Validations
  validates :content,
            :user,
            :commentable_type,
            :commentable_id,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :nickname, to: :user, allow_nil: true, prefix: true

  # Callbacks
  after_create :update_commentable_comments_count
  before_destroy :update_commentable_comments_count_on_destroy

  # Methods

  def date_str
    I18n.l(created_at, format: :shorter)
  end

  def status_str
    Comment.human_attribute_name("status.#{status}")
  end

  def origin_str
    Comment.human_attribute_name("origin.#{origin}")
  end

  def spoiler_str
    return Comment.human_attribute_name("spoiler.has_spoiler") if spoiler
    Comment.human_attribute_name("spoiler.spoiler_free")
  end

  def created_at_str
    I18n.l(created_at, format: :long) if created_at.is_a?(Time)
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

  private

  # Callbacks

  def update_commentable_comments_count
    commentable.update_comments_count
  end

  def update_commentable_comments_count_on_destroy
    commentable.update_comments_count(-1)
  end
end
