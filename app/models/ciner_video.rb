# frozen_string_literal: true

class CinerVideo < ActiveRecord::Base
  include Searchables::CinerVideo
  include FilmProfitable
  include UserActionable

  # Associations
  belongs_to :age_range
  belongs_to :user

  has_many :critics, as: :filmable
  has_many :ciner_video_users, dependent: :destroy

  # Uploaders
  # mount_uploader :trailer, CinerVideoTrailerUploader

  mount_uploader :media, CinerVideoMediaUploader

  has_attached_file :trailer
  validates_attachment :trailer, presence: true,
                        content_type: { content_type: ["video/mp4", "video/avi", "video/mov", "video/3gp"] },
                        size: { in: 0..10.gigabytes }

  has_attached_file :media
  validates_attachment :media, presence: true,
                        content_type: { content_type: ["video/mp4", "video/avi", "video/mov", "video/3gp"] },
                        size: { in: 0..10.gigabytes }

  mount_uploader :cover, CinerVideoCoverUploader

  # Validations
  validates :original_title,
            :year,
            presence: true

  # Nested
  accepts_nested_attributes_for :ciner_video_users,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Aliases
  alias_attribute :text, :title_str

  # Scopes

  def self.by_year(year)
    where(year: year)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_year(params[:year]) if params[:year].present?

    result
  end

  def original_title_str
    return original_title unless year
    original_title.gsub("(#{year})", "")
  end

  def filmable_year
    year
  end
end
