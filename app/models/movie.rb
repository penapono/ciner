# frozen_string_literal: true

class Movie < ActiveRecord::Base
  include Searchables::Movie
  include FilmProfitable
  include Tmdb
  include UserActionable

  # Associations
  belongs_to :age_range
  belongs_to :user

  has_many :critics, as: :filmable
  has_many :broadcast_broadcastables, as: :broadcastable
  has_many :broadcasts, through: :broadcast_broadcastables
  has_many :filmable_professionals, as: :filmable
  has_many :professionals, through: :filmable_professionals

  # Uploaders
  mount_uploader :cover, CoverUploader

  # Validations
  validates :original_title,
            :year,
            presence: true

  # Delegations
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :state, allow_nil: true, prefix: true
  delegate :name, to: :age_range, allow_nil: true, prefix: true

  # Nested
  accepts_nested_attributes_for :filmable_professionals,
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

  def self.current_playing
    where(playing: true).order('brazilian_release DESC')
  end

  def filmable_year
    year
  end

  def self.featured
    ids = Visit.where(action: 'show').where("controller like ?", "%questions%").pluck(:resource_id)

    result = Hash.new(0)

    ids.each { |v| result[v] += 1 }

    result = result.sort_by { |_k, v| v }.to_h

    where(id: result.keys.first(15))
  end

  def self.playing_soon
    where(playing_soon: true)
  end

  def self.available_netflix
    where(available_netflix: true)
  end

  def self.available_amazon
    where(available_amazon: true)
  end
end
