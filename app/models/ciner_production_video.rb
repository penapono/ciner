# frozen_string_literal: true

class CinerProductionVideo < ActiveRecord::Base
  # Associations
  belongs_to :ciner_production

  # Validations
  validates :video,
            presence: true

  # Scope
  default_scope { order(season: :asc, episode: :asc) }

  # Callbacks
  before_save :update_links

  # Filter

  def self.filter_by(collection, _params)
    collection
  end

  # Callbacks
  def update_links
    video.gsub!('youtube.com/watch?v=', 'youtube.com/embed/')
    video.gsub!('https://vimeo.com/', 'https://player.vimeo.com/video/')
    video.gsub!('http://vimeo.com/', 'https://player.vimeo.com/video/')
    video.gsub!('www.vimeo.com/', 'https://player.vimeo.com/video/')
    video.gsub!('https://www.vimeo.com/', 'https://player.vimeo.com/video/')
    video.gsub!('http://www.vimeo.com/', 'https://player.vimeo.com/video/')
  end
end
