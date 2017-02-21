# frozen_string_literal: true
class Event < ActiveRecord::Base
  include Searchables::Event
  include Reactionable
  include CommentManageable

  acts_as_votable

  # Validations
  validates :title,
            :description,
            :event_date,
            presence: true

  # Associations
  has_many :comments, as: :commentable

  # Filter

  def self.all_next
    where("event_date >= ?", DateTime.now).order(event_date: :asc)
  end

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection

    result
  end

  # Methods

  def description_str
    ActionView::Base.full_sanitizer.sanitize(description).truncate(155)
  end

  def event_date_str
    I18n.l(event_date, format: :simpledate) if event_date.is_a?(Date)
  end

  def start_time_str
    I18n.l(start_time, format: :simpletime) if start_time.is_a?(Time)
  end

  def end_time_str
    I18n.l(end_time, format: :simpletime) if end_time.is_a?(Time)
  end
end
