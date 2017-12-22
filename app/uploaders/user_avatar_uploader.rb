# frozen_string_literal: true

class UserAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def scale(_width, _height)
    process scale: [200, 300]
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end

  version :avatar do
    process :crop
    resize_to_fill(300, 300)
  end

  version :large do
    process :crop
    resize_to_fill(600, 600)
  end

  version :thumb do
    process :crop
  end

  def crop
    base = 300.0
    if model.crop_x.present?
      manipulate! do |img|
        converted_h = base * img.rows / img.columns
        x = (model.crop_x.to_i / base * img.columns).to_i
        y = (model.crop_y.to_i / converted_h * img.rows).to_i
        w = (model.crop_w.to_i / base * img.columns).to_i
        h = (model.crop_h.to_i / converted_h * img.rows).to_i
        img.crop!(x, y, w, h)
        img
      end
    end
  end
end
