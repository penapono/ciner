# frozen_string_literal: true
module Platform
  class HomeController < PlatformController
    # Exposes
    expose(:events) { Event.all_next.first(4) }
    expose(:critics) { Critic.only_two }
    expose(:questions) { Question.top_questions }
    expose(:broadcasts) { Broadcast.top_broadcasts.first(4) }

    expose(:playing_movies) { Movie.current_playing.first(6) }
  end
end
