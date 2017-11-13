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
            :subtitle,
            :description,
            :event_date,
            presence: true

  belongs_to :state

  # Associations
  has_many :comments, as: :commentable
  has_many :event_images, dependent: :destroy

  # Nested
  accepts_nested_attributes_for :event_images,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Aliases
  alias_attribute :title_str, :title

  # Filter

  def self.all_past
    where("event_date < ?", DateTime.now).order(event_date: :asc)
  end

  def self.all_next
    where("event_date >= ?", DateTime.now).order(event_date: :asc)
  end

  def self.by_date(date)
    date_formatted = Date.parse(date)
    ids = where(event_date: date_formatted).pluck(:id) +
          where(end_date: date_formatted).pluck(:id) +
          where("event_date <= ?", date_formatted)
          .where("end_date >= ?", date_formatted).pluck(:id)
    where(id: ids.uniq)
  end

  def self.by_state(state)
    where(state_id: state)
  end

  def self.by_event_in_time(event_in_time)
    return all_past if event_in_time == "past"
    all_next
  end

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_date(params[:date]) unless params[:date].blank?
    result = result.by_state(params[:state]) unless params[:state].blank?
    result = result.by_event_in_time(params[:event_in_time]) unless params[:event_in_time].blank?

    result
  end

  # Methods

  def description_str
    ActionView::Base.full_sanitizer.sanitize(description)
  end

  def collapsed_description
    description_str.truncate(50)
  end

  def date_str
    return event_date_str if end_date.blank?
    return event_month_date_str if event_date == end_date
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

  def event_month_date_str
    I18n.l(event_date, format: :monthname) if event_date.is_a?(Date)
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
    if event_date == end_date && event_date.month == today.month
      return 'acontecendo'
    end
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
    return 'Em breve' if (event_date - today) <= 30
    ''
  end
end
