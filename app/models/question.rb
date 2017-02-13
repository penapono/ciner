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
            :questionable_id,
            presence: true

  # Delegations
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :title_str, to: :questionable, allow_nil: true, prefix: true

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
    two_last_created = last_created.all_but(questions).first(2)
    two_last_created.each { |q| questions << q }

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

  def created_at_str
    I18n.t('shared.questions.created_at', user: user_name, date: I18n.l(created_at, format: :shorter))
  end

  # Filter

  def self.filter_by(collection, params)
    return collection unless params.present?

    result = collection
    result = result.by_questionable_type(params[:questionable_type]) if params[:questionable_type].present?
    result = result.by_questionable_id(params[:questionable_id]) if params[:questionable_id].present?
    result = result.by_status(params[:status]) if params[:status].present?
    result = result.by_origin(params[:origin]) if params[:origin].present?
    result = result.by_user_id(params[:user_id]) if params[:user_id].present?

    result
  end

  def self.by_questionable_type(questionable_type)
    where(questionable_type: questionable_type)
  end

  def self.by_questionable_id(questionable_id)
    where(questionable_id: questionable_id)
  end

  def self.by_status(status)
    where(status: status)
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
