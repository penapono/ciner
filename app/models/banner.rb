# frozen_string_literal: true

class Banner < ActiveRecord::Base
  include Searchables::Banner

  # Validations
  validates :link,
            :image,
            :position,
            presence: true

  # Scope
  default_scope { order(position: :asc) }

  # Uploaders
  mount_uploader :image, BannerImageUploader

  # Filter

  def self.filter_by(collection, _params)
    collection
  end
end
