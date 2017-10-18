# frozen_string_literal: true

module ImageHelper
  def image_default_path(image_path, image_model)
    return image_path if File.exists? image_path
    image_path("default/#{image_model}/image.jpg")
  end
end
