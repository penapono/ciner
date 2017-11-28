# frozen_string_literal: true

class Delate < ActiveRecord::Base
  # Validations
  validates :location,
            :user_id,
            presence: true

  enum status: { unread: 0, read: 1, answered: 2 }

  def subject_str
    Delate.human_attribute_name("subject.#{subject}")
  end

  def self.localized_subjects
    subjects.map { |k, w| [human_attribute_name("subject.#{k}"), w] }
  end

  def self.localized_detailed_subjects
    subjects.keys.map { |w| [human_attribute_name("subject.#{w}"), w] }
  end
end
