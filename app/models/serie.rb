# frozen_string_literal: true

class Serie < ActiveRecord::Base
  include Searchables::Serie
  include FilmProfitable
  include Tmdb

  # Associations
  belongs_to :age_range
  belongs_to :user

  has_many :critics, as: :filmable
  has_many :filmable_professionals, as: :filmable
  has_many :professionals, through: :filmable_professionals

  has_many :serie_seasons
  has_many :serie_season_episodes

  # Uploaders
  mount_uploader :cover, CoverUploader

  # Validations
  validates :original_title,
            :start_year,
            presence: true

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :state, allow_nil: true, prefix: true
  delegate :name, to: :country, allow_nil: true, prefix: true
  delegate :name, to: :age_range, allow_nil: true, prefix: true

  # Aliases
  alias_attribute :text, :title_str

  # Scopes
  def self.by_city(city)
    where(city: city)
  end

  def self.by_state(id)
    where(state_id: id)
  end

  def self.by_country(id)
    where(country_id: id)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_country(params[:country]) if params[:country].present?
    result = result.by_state(params[:state]) if params[:state].present?
    result = result.by_city(params[:city]) if params[:city].present?

    result
  end

  def original_title_str
    return original_title unless start_year
    original_title.gsub("(#{start_year})", "")
  end

  def self.current_playing
    where(playing: true).order(brazilian_release: :desc)
  end

  def self.most_viewed
    ids = Visit.where(action: 'show').where("controller like ?", "%series%").pluck(:resource_id)

    result = Hash.new(0)

    ids.each { |v| result[v] += 1 }

    result = result.sort_by { |_k, v| v }.to_h

    where(id: result.keys.first(15))
  end
end
