# frozen_string_literal: true

module ImageHelper
  def image_default_path(image, image_model)
    return "assets/default/#{image_model}/image.jpg" if image.blank?
    image_path = if image.class == String
                   image
                 else
                   image.path
                 end
    return image.url if image_path && (File.exist? image_path)
    "assets/default/#{image_model}/image.jpg"
  end
end
