# frozen_string_literal: true

class CurriculumAudio < ActiveRecord::Base
  belongs_to :curriculum

  # Uploaders
  mount_uploader :media, CurriculumAudioUploader

  # Validations
  validates :media,
            presence: true

  validates :media, file_size: { less_than: 3.megabytes }
end
