# frozen_string_literal: true
class HomeController < ApplicationController
  expose(:events) { Event.all_next.first(2) }
  expose(:critics) { Critic.only_two }
  expose(:questions) { Question.top_questions }

  def index
    redirect_to platform_root_path if user_signed_in?
  end
end
