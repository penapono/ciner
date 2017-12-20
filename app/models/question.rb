# frozen_string_literal: true

class Question < ActiveRecord::Base
  include Searchables::Question
  include Reactionable
  include CommentManageable
  include Visitable

  acts_as_votable

  # Enums
  enum status: { pending: 1, approved: 2, reproved: 3 }
  enum origin: { ciner_question: 1, user_question: 2 }

  # Associations
  belongs_to :user

  belongs_to :questionable, polymorphic: true

  has_many :comments, as: :commentable

  # Validations
  validates :title,
            :content,
            :user,
            :questionable_type,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :nickname, to: :user, allow_nil: true, prefix: true
  delegate :title_str, to: :questionable, allow_nil: true, prefix: true

  # Aliases
  alias_attribute :title_str, :title

  # Scopes

  def self.ordered_by_status
    order(status: :asc)
  end

  def self.ciner_official_question
    find_by(origin: 1)
  end

  def self.more_commented
    order(comments_count: :desc)
  end

  def self.last_created
    order(created_at: :desc)
  end

  def self.all_but(objects)
    ids = []

    objects.each { |q| ids << q.id }
    where.not(id: ids)
  end

  def self.top_questions
    questions = []

    more_commented.first(2).each { |q| questions << q }
    three_last_created = last_created.all_but(questions).first(4)
    three_last_created.each { |q| questions << q }

    questions
  end

  # Methods

  def status_str
    Question.human_attribute_name("status.#{status}")
  end

  def origin_str
    Question.human_attribute_name("origin.#{origin}")
  end

  def self.localized_questionable_types
    [['Filme', Movie], ['Série', Serie], ['Profissional', Professional]]
  end

  def spoiler_str
    return Question.human_attribute_name("spoiler.has_spoiler") if spoiler
    Question.human_attribute_name("spoiler.spoiler_free")
  end

  def date_str
    I18n.l(created_at, format: :shorter)
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_area(params[:area]) if params[:area].present?
    result = result.by_time(params[:time]) if params[:time].present?

    result
  end

  def self.by_area(area)
    if area == "movies"
      where(questionable_type: 'Movie')
    elsif area == "series"
      where(questionable_type: 'Serie')
    elsif area == "general"
      all
    end
  end

  def self.by_time(time)
    return order(comments_count: :desc) if time == "more_comment"
    return order(likes_count: :desc) if time == "more_like"
    return featured if time == "more_views"
    return order(created_at: :desc) if time == "recent"
    return order(created_at: :asc) if time == "oldest"
  end

  def self.featured
    result = Hash.new(0)

    Question.all.each do |object|
      result[object.id] = object.visits_count
    end

    result = result.sort_by { |_k, v| v }.to_h

    where(id: result.keys)
  end

  def self.localized_statuses
    statuses.map { |k, w| [human_attribute_name("status.#{k}"), w] }
  end

  def self.localized_detailed_statuses
    statuses.keys.map { |w| [human_attribute_name("status.#{w}"), w] }
  end

  def self.by_origin(origin)
    where(origin: origin)
  end

  def self.localized_origins
    origins.map { |k, w| [human_attribute_name("origin.#{k}"), w] }
  end

  def self.by_user_id(user_id)
    where(user: User.find(user_id))
  end
end
