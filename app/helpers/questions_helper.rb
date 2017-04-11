# frozen_string_literal: true

module QuestionsHelper
  def question_class(question)
    return 'filme' if questionable_type(question) == "Movie"
    return 'serie' if questionable_type(question) == "Serie"
    'offtopic'
  end

  def question_icon(question)
    return '#filme-debate' if questionable_type(question) == "Movie"
    return '#serie' if questionable_type(question) == "Serie"
    '#offtopic'
  end

  def question_created_at_str(question)
    I18n.t('shared.questions.created_at', user: question.user_name, date: l(question.created_at, format: :shorter))
  end

  private

  def questionable_type(question)
    question.questionable_type.to_s
  end
end
