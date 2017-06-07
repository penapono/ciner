# frozen_string_literal: true

class CinerVideo < ActiveRecord::Base
  include Searchables::CinerVideo
  include FilmProfitable
  include UserActionable

  # Associations
  belongs_to :age_range
  belongs_to :user

  has_many :critics, as: :filmable

  # Uploaders
  mount_uploader :trailer, CinerVideoTrailerUploader
  mount_uploader :media, CinerVideoMediaUploader

  # Validations
  validates :original_title,
            :year,
            presence: true

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
