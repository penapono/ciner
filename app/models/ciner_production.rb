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

  # has_many :critics, as: :filmable, dependent: :destroy
  # has_many :user_filmable_ratings, as: :filmable, dependent: :destroy
  # has_many :broadcast_broadcastables, as: :broadcastable, dependent: :destroy
  # has_many :broadcasts, through: :broadcast_broadcastables
  has_many :ciner_production_professionals
  has_many :ciner_production_videos
  # has_many :user_filmables, as: :filmable, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy

  # Uploaders
  mount_uploader :cover, CoverUploader

  # Validations
  validates :original_title,
            :year,
            presence: true

  # Nested
  accepts_nested_attributes_for :ciner_production_professionals,
                                allow_destroy: true,
                                reject_if: :all_blank

  accepts_nested_attributes_for :ciner_production_videos,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Aliases
  alias_attribute :text, :title_str

  # Enums
  enum type: { movie_production: 0, serie_production: 1 }
  enum status: { pending: 0, approved: 1, reproved: 2 }

  # Callbacks
  before_destroy :destroy_visits
  before_create :pending_approval
  after_create :send_admin_notification
  before_update :pending_approval

  # Scopes

  default_scope { where(status: :approved) }

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

  def length_str
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

  def pending_approval
    if status == :pending
      self.status = :reproved
    elsif status == :reproved
      self.status = :pending
    elsif status.nil?
      self.status = :pending
    end
  end

  def send_admin_notification
    byebug
    notification = Notification.create(
      sender_id: user_id,
      message: id,
      receiver_id: User.find_by(role: :admin).id,
      notification_type: :ciner_production_pending,
      answer: :waiting
    )
  end
end
