# encoding: utf-8
# frozen_string_literal: true

class CinerVideoTrailerUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video
  include ::CarrierWave::Backgrounder::Delay

  process encode_video: [:mp4, callbacks: { before_transcode: :set_success }]
end
