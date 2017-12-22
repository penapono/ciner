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
    user_link =
      link_to(
        question.user_nickname,
        Rails.application.routes.url_helpers.platform_user_path(
          question.user
        )
      )

    I18n.t('shared.questions.created_at',
           user: user_link,
           date: I18n.l(question.created_at,
                        format: :shorter)).html_safe
  end

  private

  def questionable_type(question)
    question.questionable_type.to_s
  end
end
