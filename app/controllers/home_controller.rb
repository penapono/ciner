# frozen_string_literal: true

class HomeController < ApplicationController
  # Exposes
  expose(:events) { Event.all_next.first(4) }
  expose(:critics) { Critic.all }
  expose(:questions) { Question.top_questions }
  expose(:broadcasts) { Broadcast.top_broadcasts.last(7) }

  expose(:playing_movies) { Movie.current_playing }
  expose(:featured_movies) { Movie.most_viewed.first(5) }

  def index
    redirect_to platform_root_path if user_signed_in?
  end
end
