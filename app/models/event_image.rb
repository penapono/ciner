# frozen_string_literal: true

class EventImage < ActiveRecord::Base
  belongs_to :event

  # Uploaders
  mount_uploader :media, EventImageUploader

  # Validations
  validates :media,
            presence: true

  validates :media, file_size: { less_than: 2.megabytes }
end
