# frozen_string_literal: true

module Admin
  class MovieDuplicatesController < AdminController
    PER_PAGE = 100

    # exposes
    expose(:movie_duplicates) { MovieDuplicate.order(created_at: :desc) }

    def index
      self.movie_duplicates = paginated_movie_duplicates
    end

    private

    def paginated_movie_duplicates
      movie_duplicates.page(params[:page]).per(PER_PAGE)
    end
  end
end
