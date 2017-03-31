# frozen_string_literal: true
class HomeController < ApplicationController
  # Exposes
  expose(:events) { Event.all_next.first(4) }
  expose(:critics) { Critic.only_two }
  expose(:questions) { Question.top_questions }
  expose(:broadcasts) { Broadcast.top_broadcasts.last(7) }

  expose(:playing_movies) { Movie.current_playing }

  def index
    redirect_to platform_root_path if user_signed_in?
  end
end
