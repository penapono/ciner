# frozen_string_literal: true

class CurriculumVideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video

  process encode_video: [:mp4]
end
