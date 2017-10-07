# frozen_string_literal: true

class Serie < ActiveRecord::Base
  include Searchables::Serie
  include FilmProfitable
  include Tmdb
  include UserActionable
  include CommentManageable

  # Associations
  belongs_to :age_range
  belongs_to :user

  has_many :critics, as: :filmable
  has_many :broadcast_broadcastables, as: :broadcastable
  has_many :broadcasts, through: :broadcast_broadcastables
  has_many :filmable_professionals, as: :filmable
  has_many :professionals, through: :filmable_professionals

  has_many :comments, as: :commentable

  has_many :serie_seasons
  has_many :serie_season_episodes

  # Uploaders
  mount_uploader :cover, CoverUploader

  # Validations
  validates :original_title,
            :start_year,
            presence: true

  # Delegations
  delegate :name, to: :age_range, allow_nil: true, prefix: true

  # Nested
  accepts_nested_attributes_for :filmable_professionals,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :serie_seasons,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Aliases
  alias_attribute :text, :title_str

  # Scopes

  def self.by_year(year)
    where(start_year: year)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_year(params[:year]) if params[:year].present?

    result
  end

  def original_title_str
    return original_title unless start_year
    original_title.gsub("(#{start_year})", "")
  end

  def self.current_playing
    where(playing: true).order(brazilian_release: :desc)
  end

  def filmable_year
    start_year
  end

  def self.featured
    ids = Visit.where(action: 'show').where("controller like ?", "%series%").pluck(:resource_id)

    result = Hash.new(0)

    ids.each { |v| result[v] += 1 }

    result = result.sort_by { |_k, v| v }.to_h

    where(id: result.keys.first(15))
  end

  def self.playing
    where(last_released: true)
  end
end
