# frozen_string_literal: true

class MoviesController < ApplicationController
  include MoviesBreadcrumb

  # exposes
  expose(:movies) { Movie.all }
  expose(:playing) { Movie.current_playing }
  expose(:playing_soon) { Movie.playing_soon }
  expose(:featured) { Movie.featured.first(10) }
  expose(:available_netflix) { Movie.available_netflix }
  expose(:available_amazon) { Movie.available_amazon }
  expose(:birthday_professionals) { Professional.birthdays }
  expose(:movie, attributes: :movie_attributes)

  expose(:age_ranges) { AgeRange.all }

  # Filters

  expose(:filtered_states) { filtered_states }
  expose(:filtered_cities) { filtered_cities }

  PER_PAGE = 50

  def index
    self.movies = paginated_movies
  end

  def show
    movie.api_transform
  end

  private

  def resource
    movie
  end

  def resource_title
    movie.title
  end

  def index_path
    movies_path
  end

  def show_path
    movie_path(resource)
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
    filtered_movie.page(params[:page]).per(PER_PAGE)
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
