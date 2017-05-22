# frozen_string_literal: true

class Event < ActiveRecord::Base
  include Searchables::Event
  include Reactionable
  include CommentManageable

  acts_as_votable

  # Uploaders
  mount_uploader :cover, EventCoverUploader

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

  def collapsed_description
    description_str.truncate(50)
  end

  def date_str
    return event_date_str if end_date.blank?
    "#{event_date_str} a #{end_date_str}"
  end

  def time_str
    return "" if start_time.blank? && end_time.blank?
    return "às #{start_time_str}" if end_time.blank?
    return "às #{end_time_str}" if start_time.blank?
    "das #{start_time_str} às #{end_time_str}"
  end

  def datetime_str
    "#{date_str} #{time_str}"
  end

  def event_date_str
    I18n.l(event_date, format: :simpledate) if event_date.is_a?(Date)
  end

  def end_date_str
    I18n.l(end_date, format: :simpledate) if end_date.is_a?(Date)
  end

  def start_time_str
    I18n.l(start_time, format: :simpletime) if start_time.is_a?(Time)
  end

  def end_time_str
    I18n.l(end_time, format: :simpletime) if end_time.is_a?(Time)
  end

  def status_str
    today = Date.today
    if (end_date.blank? && event_date == today) ||
       (!end_date.blank? && event_date <= today && today <= end_date)
      now = DateTime.now
      if start_time
        if (end_time.blank? && start_time <= now) ||
           (!end_time.blank? && start_time <= now && now >= end_time)
          return 'acontecendo'
        end
      else
        return 'acontecendo'
      end
    end
    if (event_date - today) <= 30
      return 'breve'
    end
    ''
  end
end
