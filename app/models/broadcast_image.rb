# frozen_string_literal: true

class BroadcastImage < ActiveRecord::Base
  belongs_to :broadcast

  # Uploaders
  mount_uploader :media, BroadcastImageUploader

  # Validations
  validates :media,
            presence: true

  validates :media, file_size: { less_than: 2.megabytes }
end
