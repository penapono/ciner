# frozen_string_literal: true
class SeriesController < ApplicationController
  include SeriesBreadcrumb

  # exposes
  expose(:series) { Serie.all }
  expose(:serie, attributes: :serie_attributes)

  expose(:countries) { Country.all }
  expose(:age_ranges) { AgeRange.all }

  # Filters

  expose(:filtered_states) { filtered_states }
  expose(:filtered_cities) { filtered_cities }

  PER_PAGE = 50

  def index
    self.series = paginated_series
  end

  def show
    serie.api_transform
  end

  private

  def resource
    serie
  end

  def resource_title
    serie.title
  end

  def index_path
    series_index_path
  end

  def show_path
    serie_path(resource)
  end

  def serie_params
    params.require(:serie).permit(
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
    serie_params
  end

  # Filtering

  def paginated_series
    filtered_serie.page(params[:page]).per(PER_PAGE)
  end

  def filtered_serie
    series.filter_by(searched_series, params.fetch(:filter, ''))
  end

  def searched_series
    series.search(current_user, params.fetch(:search, ''))
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