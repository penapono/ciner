# frozen_string_literal: true
module Admin
  class HomeController < AdminController
    # Exposes
    expose(:events) { Event.all_next.first(4) }
    expose(:critics) { Critic.only_two }
    expose(:questions) { Question.top_questions }
    expose(:broadcasts) { Broadcast.top_broadcasts.last(7) }

    expose(:playing_movies) { Movie.current_playing }
  end
end
