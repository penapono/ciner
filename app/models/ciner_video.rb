# frozen_string_literal: true

class CinerVideo < ActiveRecord::Base
  include Searchables::CinerVideo
  include FilmProfitable
  include UserActionable

  serialize :countries
  serialize :film_production_categories
  serialize :ciner_video_ratings

  # Enums
  enum status: { pending: 1, approved: 2, reproved: 3 }

  # Associations
  belongs_to :age_range
  belongs_to :user

  has_many :critics, as: :filmable
  has_many :ciner_video_users, dependent: :destroy

  # Uploaders
  mount_uploader :trailer, CinerVideoTrailerUploader
  mount_uploader :media, CinerVideoMediaUploader

  has_attached_file :trailer
  validates_attachment :trailer,
                       content_type: { content_type: [/\Aimage\/.*\Z/, /\Avideo\/.*\Z/] },
                       size: { in: 0..10.gigabytes }, if: Proc.new { |a| a.trailer.present? }


  has_attached_file :media
  validates_attachment :media,
                       content_type: { content_type: [/\Aimage\/.*\Z/, /\Avideo\/.*\Z/] },
                       size: { in: 0..10.gigabytes }

  process_in_background :media
  process_in_background :trailer

  before_validation(on: [:save, :update]) do
    byebug
    if self.trailer_processing?
      Delayed::Worker.new.run(Delayed::Job.last)
    end

    if self.media_processing?
      Delayed::Worker.new.run(Delayed::Job.last)
    end
  end

  mount_uploader :cover, CinerVideoCoverUploader

  # Validations
  validates :original_title,
            presence: true

  # Nested
  accepts_nested_attributes_for :ciner_video_users,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Aliases
  alias_attribute :text, :title_str

  # Scopes

  def countries_str
    Country.where(id: self.countries).pluck(:name).to_sentence
  end

  def ciner_video_ratings_str
    AgeRange.where(id: self.ciner_video_ratings).pluck(:name).to_sentence
  end

  def film_production_categories_str
    FilmProductionCategory.where(id: self.film_production_categories).pluck(:name).to_sentence
  end

  def self.by_year(year)
    where(year: year)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_year(params[:year]) if params[:year].present?
    result = result.by_status(params[:status]) if params[:status].present?

    result
  end

  def self.by_status(status)
    where(status: status)
  end

  def original_title_str
    return original_title unless year
    original_title.gsub("(#{year})", "")
  end

  def filmable_year
    year
  end

  def self.localized_statuses
    statuses.map { |k, w| [human_attribute_name("status.#{k}"), w] }
  end

  def self.localized_detailed_statuses
    statuses.keys.map { |w| [human_attribute_name("status.#{w}"), w] }
  end
end
