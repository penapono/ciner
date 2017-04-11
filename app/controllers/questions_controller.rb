# frozen_string_literal: true

class QuestionsController < ApplicationController
  include QuestionsBreadcrumb

  # exposes
  expose(:questions) { Question.approved }
  expose(:question, attributes: :question_attributes)
  expose(:movies) { Movie.first(20) }
  expose(:series) { Serie.first(20) }
  expose(:professionals) { Serie.first(20) }
  expose(:users) { User.all }

  PER_PAGE = 10

  def index
    self.questions = paginated_questions
  end

  private

  def resource
    question
  end

  def resource_title
    question.title
  end

  def index_path
    admin_questions_path
  end

  def show_path
    admin_question_path(resource)
  end

  def resource_params
    question_params
  end

  # Filtering

  def paginated_questions
    filtered_question.page(params[:page]).per(PER_PAGE)
  end

  def filtered_question
    questions.filter_by(searched_questions, params.fetch(:filter, ''))
  end

  def searched_questions
    questions.search(current_user, params.fetch(:search, ''))
  end
end
