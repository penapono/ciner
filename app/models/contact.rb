# frozen_string_literal: true

class Contact < ActiveRecord::Base
  # Validations
  validates :name,
            :email,
            :subject,
            :message,
            presence: true

  enum subject: { compliment: 0, suggestion: 1, complaint: 2,
                  financial: 3, other: 4 }

  def subject_str
    Contact.human_attribute_name("subject.#{subject}")
  end

  def self.localized_subjects
    subjects.map { |k, w| [human_attribute_name("subject.#{k}"), w] }
  end

  def self.localized_detailed_subjects
    subjects.keys.map { |w| [human_attribute_name("subject.#{w}"), w] }
  end
end
