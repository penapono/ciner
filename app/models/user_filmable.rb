# frozen_string_literal: true

class UserFilmable < ActiveRecord::Base
  include Searchables::UserFilmable

  acts_as_paranoid

  # Validations
  validates :user,
            :filmable_id,
            :filmable_type,
            :action,
            presence: true

  # Enums
  enum action: { watched: 1, want_to_see: 2, collection: 3, favorite: 4, like: 5 }
  enum media: { bluray: 1, dvd: 2, digital: 3, vhs: 4, other_media: 5 }
  enum version: { simple: 1, double: 2, collector: 3, commemorative: 4, other_version: 5 }

  # Associations
  belongs_to :user
  belongs_to :filmable, polymorphic: true

  # Uploaders
  mount_uploader :cover, CoverUploader

  # Scope
  default_scope { order('(position IS NULL) ASC, position ASC') }

  def media_str
    return 'Blu-Ray' if bluray?
    return 'DVD' if dvd?
    return 'Digital' if digital?
    return 'VHS' if vhs?
    'Outra Mídia'
  end

  def version_str
    return 'Simples' if simple?
    return 'Duplo' if double?
    return 'Colecionador' if collector?
    return 'Comemorativa' if commemorative?
    'Outra Versão'
  end

  def event_date_str
    I18n.l(bought, format: :simpledate) if event_date.is_a?(Date)
  end

  def title_str
    return filmable.title unless collection?
    media_str + " - " + version_str
  end

  def self.by_gift(gift)
    where(gift: gift)
  end

  def self.by_box(box)
    where(box: box)
  end

  def self.by_media(media)
    where(media: media)
  end

  def self.by_version(version)
    where(version: version)
  end

  def self.by_alphabet(result)
    ids = result

    hash_result = Hash.new(0)

    ids.each { |v| hash_result[v] = v.filmable.title }

    hash_result = hash_result.sort_by { |_k, v| v }.to_h

    hash_result.keys
  end

  def self.by_new_year(result)
    ids = result

    hash_result = Hash.new(0)

    ids.each { |v| hash_result[v] = v.filmable.filmable_year }

    hash_result = hash_result.sort_by { |_k, v| v }.to_h

    hash_result.keys
  end

  def self.by_old_year(result)
    ids = result

    hash_result = Hash.new(0)

    ids.each { |v| hash_result[v] = v.filmable.filmable_year }

    hash_result = hash_result.sort_by { |_k, v| v }.to_h

    hash_result.keys.reverse
  end

  def self.by_order(result, order)
    return by_alphabet(result) if order == "alphabet"

    return by_new_year(result) if order == "newly"

    return by_old_year(result) if order == "oldly"

    return order(bought: :desc) if order == "newly_bought"

    return order(bought: :asc) if order == "oldly_bought"

    return order(price: :desc) if order == "expensive"

    return order(price: :asc) if order == "cheap"

    order(position: :asc)
  end

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_media(params[:media]) unless params[:media].blank?
    result = result.by_version(params[:version]) unless params[:version].blank?
    result = result.by_box(params[:box]) unless params[:box].blank?
    result = result.by_gift(params[:gift]) unless params[:gift].blank?
    result = result.by_price(params[:price]) unless params[:price].blank?
    result = result.by_bought(params[:bought]) unless params[:bought].blank?
    result = result.by_order(result, params[:order]) unless params[:order].blank?
    result
  end
end
