# frozen_string_literal: true

class UserFilmable < ActiveRecord::Base
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

  def title_str
    return filmable.title unless collection?
    media_str + " - " + version_str
  end
end
