# frozen_string_literal: true

module HomeContentsController
  extend ActiveSupport::Concern

  included do
    # Exposes
    expose(:events) { Event.all_next.first(4) }
    expose(:critics) { Critic.home }
    expose(:questions) { Question.top_questions }
    expose(:broadcasts) { Broadcast.top_broadcasts.last(4) }
    expose(:ciner_videos) { CinerVideo.approved.order(updated_at: :desc).last(4) }

    expose(:playing_movies) { Movie.current_playing }
    expose(:featured_movies) { Movie.most_viewed.first(5) }
  end
end
