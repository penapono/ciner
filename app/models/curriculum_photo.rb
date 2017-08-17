# frozen_string_literal: true

class CurriculumPhoto < ActiveRecord::Base
  belongs_to :curriculum

  # Uploaders
  mount_uploader :media, CurriculumPhotoUploader

  # Validations
  validates :media,
            presence: true

  validates :media, file_size: { less_than: 50.megabytes }
end
