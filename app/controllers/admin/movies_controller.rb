# frozen_string_literal: true

module Admin
  class MoviesController < AdminController
    include Admin::MoviesBreadcrumb

    # exposes
    expose(:movies) { Movie.all }
    expose(:movie, attributes: :movie_attributes)
    expose(:broadcasts) { movie.broadcasts }
    expose(:age_ranges) { AgeRange.all }

    expose(:playing_filmables) { Movie.current_playing }
    expose(:playing_soon_filmables) { Movie.playing_soon }
    expose(:featured_filmables) { Movie.featured(10) }
    expose(:available_netflix_filmables) { Movie.available_netflix.limit(20) }

    PER_PAGE = 100

    def index
      self.movies = paginated_movies
    end

    def show
      force_update = params[:force_update].present? && params[:force_update] == "true" ? true : false
      movie.api_transform(force_update)
    end

    def bulk_destroy
      if params[:destroy] && params[:destroy][:ids]
        ids = params[:destroy][:ids]
        ids.each do |id_to_destroy|
          status = Movie.find(id_to_destroy).destroy
        end
        respond_to do |format|
          format.json do
            if status
              render json: { status: 'OK' }
            else
              render json: { status: 'error' }
            end
          end
        end
      end
    end

    private

    def resource
      movie
    end

    def resource_title
      movie.title
    end

    def index_path
      admin_movies_path
    end

    def show_path
      admin_movie_path(resource)
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
        :city_id,
        :state_id,
        :country_id,
        :age_range_id,
        :cover,
        :studio_id,
        :created_at,
        :updated_at,
        :omdb_directors,
        :omdb_writers,
        :omdb_actors,
        :omdb_genre,
        :omdb_rated,
        :omdb_id,
        :omdb_trailer,
        :trailer,
        :tmdb_id,
        :imdb_id,
        :playing,
        :user_id,
        :lock_updates,
        :countries,
        :playing_soon,
        :available_netflix,
        :available_amazon,
        filmable_professionals_attributes: %i[
          set_function_id
          professional_id
          observation
          filmable_id
          filmable_type
          filmable
          id
          _destroy
        ]
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
