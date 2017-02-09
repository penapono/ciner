# frozen_string_literal: true
class Comment < ActiveRecord::Base
  include Reactionable

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

  # Scopes

  def self.ordered_by_status
    order(status: :asc)
  end

  def self.ciner_official_comment
    find_by(origin: 1)
  end

  # Methods

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

  # Filter

  # def self.filter_by(collection, params)
  #   return collection unless params.present?

  #   result = collection
  #   result = result.by_commentable_type(params[:commentable_type]) if params[:commentable_type].present?
  #   result = result.by_commentable_id(params[:commentable_id]) if params[:commentable_id].present?
  #   result = result.by_status(params[:status]) if params[:status].present?
  #   result = result.by_origin(params[:origin]) if params[:origin].present?
  #   result = result.by_user_id(params[:user_id]) if params[:user_id].present?

  #   result
  # end

  # def self.by_commentable_type(commentable_type)
  #   where(commentable_type: commentable_type)
  # end

  # def self.by_commentable_id(commentable_id)
  #   where(commentable_id: commentable_id)
  # end

  # def self.by_status(status)
  #   where(status: status)
  # end

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
end
