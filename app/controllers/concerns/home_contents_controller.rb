# frozen_string_literal: true

module HomeContentsController
  extend ActiveSupport::Concern

  included do
    # Exposes
    expose(:events) { Event.all_next.first(4) }
    expose(:critics) { Critic.where(quick: false).ordered_by_status.first(6) }
    expose(:questions) { Question.includes(:user).top_questions }
    expose(:broadcasts) { Broadcast.top_broadcasts.first(4) }
    expose(:trending_trailers) { TrendingTrailer.includes(:filmable).first(3) }

    expose(:playing_movies) { Movie.current_playing.limit(10) }
    expose(:playing_series) { Serie.current_playing.limit(10) }
    expose(:playing_soon_filmables) { Movie.playing_soon.limit(10) }
    expose(:featured_movies) { Movie.featured(10) }
    expose(:ciner_productions) { CinerProduction.approved.includes(:user, :ciner_production_videos).first(4) }
  end
end
