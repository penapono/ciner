# frozen_string_literal: true

class Serie < ActiveRecord::Base
  include Searchables::Serie
  include FilmProfitable
  include Tmdb
  include UserActionable
  include CommentManageable

  # Prevents deleting
  acts_as_paranoid

  # Associations
  belongs_to :age_range
  belongs_to :user

  has_many :critics, as: :filmable, dependent: :destroy
  has_many :broadcast_broadcastables, as: :broadcastable, dependent: :destroy
  has_many :broadcasts, through: :broadcast_broadcastables
  has_many :filmable_professionals, as: :filmable, dependent: :destroy
  has_many :professionals, through: :filmable_professionals

  has_many :comments, as: :commentable, dependent: :destroy

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

  # Enums
  enum status: { running: 0, renewed: 1, finished: 2, cancelled: 3 }

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

  def filmable_year_str
    return "(#{start_year}-#{finish_year})" unless finish_year.blank?
    "(#{start_year}-)"
  end

  def status_str
    return nil if status.blank?
    Serie.human_attribute_name("status.#{status}")
  end

  def length_str
    return "#{number_of_seasons} temporadas - #{status_str}" unless status_str.blank?
    "#{number_of_seasons} temporadas"
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

  def self.localized_statuses
    statuses.map { |k, w| [human_attribute_name("status.#{k}"), w] }
  end

  def self.localized_detailed_statuses
    statuses.keys.map { |w| [human_attribute_name("status.#{w}"), w] }
  end
end
