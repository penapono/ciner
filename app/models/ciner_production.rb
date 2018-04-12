# frozen_string_literal: true

class CinerProduction < ActiveRecord::Base
  include Searchables::CinerProduction
  include FilmProfitable
  # include UserActionable
  # include CommentManageable
  include Reactionable

  # Prevents deleting
  acts_as_paranoid

  acts_as_votable

  # Associations
  belongs_to :user
  belongs_to :age_range

  has_many :ciner_production_professionals, dependent: :destroy
  has_many :ciner_production_videos, dependent: :destroy
  has_many :ciner_production_film_production_categories, dependent: :destroy
  has_many :ciner_production_countries, dependent: :destroy

  has_many :film_production_categories, through: :ciner_production_film_production_categories
  has_many :countries, through: :ciner_production_countries
  has_many :comments, as: :commentable, dependent: :destroy

  # Uploaders
  mount_uploader :cover, CoverUploader
  validates :cover, file_size: { less_than_or_equal_to: 50.kilobytes }

  # Validations
  validates :original_title,
            :title,
            :year,
            :synopsis,
            :brazilian_release,
            :age_range_id,
            presence: true

  # Nested
  accepts_nested_attributes_for :ciner_production_professionals,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :ciner_production_videos,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :ciner_production_film_production_categories,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :ciner_production_countries,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Aliases
  alias_attribute :text, :title_str

  # Enums
  enum production_type: { movie_production: 0, serie_production: 1 }
  enum status: { pending: 0, approved: 1, reproved: 2 }

  # Callbacks
  before_destroy :destroy_visits

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

  def seasons
    ciner_production_videos.pluck(:season).uniq
  end

  def season_episodes(season)
    ciner_production_videos.where(season: season)
  end

  def rated_pt
    return age_range.name unless age_range.blank?
    "-"
  end

  def countries_str
    return countries.pluck(:name).to_sentence unless countries.blank?
    "-"
  end

  def genre_pt
    return "-" if film_production_categories.blank?
    film_production_categories.pluck(:name).to_sentence
  end

  def critics
    nil
  end

  def filmable_actors
    ciner_production_professionals.includes(:user).where(curriculum_function_id: CurriculumFunction.where(name: 'Ator').pluck(:id))
  end

  def filmable_directors
    ciner_production_professionals.includes(:user).where(curriculum_function_id: CurriculumFunction.where(name: 'Diretor').pluck(:id))
  end

  def filmable_writers
    ciner_production_professionals.includes(:user).where(curriculum_function_id: CurriculumFunction.where(name: 'Roteirista').pluck(:id))
  end

  def actors
    User.where(id: filmable_actors.pluck(:user_id))
  end

  def directors
    User.where(id: filmable_directors.pluck(:user_id))
  end

  def writers
    User.where(id: filmable_writers.pluck(:user_id))
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

  def filmable_year_str
    "(#{year})"
  end

  def original_title_filmable_str
    "#{original_title_str} #{filmable_year_str}"
  end

  def serie_length_str
    return "-" if ciner_production_videos.blank?
    maximum = ciner_production_videos.pluck(:season).max
    return "#{maximum} temporada(s)" unless maximum.blank?
    "-"
  end

  def length_str
    return serie_length_str if serie_production?
    movie_length_str
  end

  def movie_length_str
    length = self.length
    return "" unless length
    length = begin
               Integer(length.gsub("min", "").strip)
             rescue StandardError
               0
             end
    hours = 0
    while length >= 60
      length -= 60
      hours += 1
    end

    return "#{hours}h" if length == 0 && hours > 0
    return "#{length}min" if length > 0 && hours == 0
    return "#{hours}h#{length}min" if length > 0 && hours > 0
    ""
  end

  def status_str
    CinerProduction.human_attribute_name("status.#{status}")
  end

  def self.featured(limit = 15)
    ids = Visit.where(action: 'show').where("controller like ?", "%ciner_productions%").pluck(:resource_id)

    result = Hash.new(0)

    ids.each { |v| result[v] += 1 }

    result = result.sort_by { |_k, v| v }.to_h

    where(id: result.keys.first(limit * 3)).limit(limit)
  end

  def destroy_visits
    object = self
    Visit.where("action = 'show' AND controller LIKE ? AND resource_id = ?", "%#{object.class.name.pluralize.downcase}%", object.id).destroy_all
  end
end
