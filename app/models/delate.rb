# frozen_string_literal: true

class Delate < ActiveRecord::Base
  # Validations
  validates :location,
            :user_id,
            presence: true

  # Associations
  belongs_to :user

  # Enums
  enum status: { unread: 0, read: 1, answered: 2 }

  # Delegate
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :nickname, to: :user, allow_nil: true, prefix: true
  delegate :cover, to: :user, allow_nil: true, prefix: true

  def subject_str
    Delate.human_attribute_name("subject.#{subject}")
  end

  def self.localized_subjects
    subjects.map { |k, w| [human_attribute_name("subject.#{k}"), w] }
  end

  def self.localized_detailed_subjects
    subjects.keys.map { |w| [human_attribute_name("subject.#{w}"), w] }
  end

  def created_at_str
    (I18n.l created_at, format: :short)
  end
end
