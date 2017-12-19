# frozen_string_literal: true

module Platform
  class MoviesController < PlatformController
    include Platform::MoviesBreadcrumb

    # exposes
    expose(:movies) { Movie.all }
    expose(:birthday_professionals) { Professional.birthdays }
    expose(:movie, attributes: :movie_attributes)
    expose(:broadcasts) { movie.broadcasts }
    expose(:age_ranges) { AgeRange.all }

    expose(:playing_filmables) { Movie.current_playing }
    expose(:playing_soon_filmables) { Movie.playing_soon }
    expose(:featured_filmables) { Movie.featured.first(10) }
    expose(:available_netflix_filmables) { Movie.available_netflix }

    PER_PAGE = 50

    def index
      self.movies = paginated_movies
    end

    def show
      force_update = params[:force_update].present? && params[:force_update] == "true" ? true : false
      movie.api_transform(force_update)
    end

    private

    def resource
      movie
    end

    def resource_title
      movie.title
    end

    def index_path
      platform_movies_path
    end

    def show_path
      platform_movie_path(resource)
    end

    def movie_params
      params.require(:movie).permit(
        :original_title,
        :title,
        :year,
        :length,
        :synopsis,
        :release,
        :brazilian_release,
        :country_id,
        :age_range_id,

        :cover,

        # Movie

        :studio,

        # Ciner Movie

        :approval,
        :approver,
        :owner,

        # Serie

        :season,
        :number_episodes,
        :aired_episodes
      )
    end

    def resource_params
      movie_params
    end

    # Filtering

    def paginated_movies
      filtered_movie.order(original_title: :asc).page(params[:page]).per(PER_PAGE)
    end

    def filtered_movie
      movies.filter_by(searched_movies, params.fetch(:filter, ''))
    end

    def searched_movies
      movies.search(current_user, params.fetch(:search, ''))
    end

    # Filters

    def filtered_states
      return unless params[:filter] && params[:filter][:country].present?
      Country.find(params[:filter][:country]).states
    end

    def filtered_cities
      return unless params[:filter] && params[:filter][:state].present?
      State.find(params[:filter][:state]).cities
    end
  end
end
