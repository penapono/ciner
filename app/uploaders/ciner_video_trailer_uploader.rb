# frozen_string_literal: true

class CinerVideoTrailerUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video

  process encode_video: [:mp4, callbacks: { after_transcode: :set_success }]
end
