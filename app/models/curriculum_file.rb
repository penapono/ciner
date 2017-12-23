# frozen_string_literal: true

class CurriculumFile < ActiveRecord::Base
  belongs_to :curriculum

  # Uploaders
  mount_uploader :media, CurriculumFileUploader

  # Validations
  validates :media,
            presence: true

  validates :media, file_size: { less_than: 1.megabytes }
end
