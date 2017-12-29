# frozen_string_literal: true

module Platform
  class SeriesController < PlatformController
    include Platform::SeriesBreadcrumb

    # exposes
    expose(:series) { Serie.all }
    expose(:birthday_professionals) { Professional.birthdays }
    expose(:serie, attributes: :serie_attributes)
    expose(:broadcasts) { serie.broadcasts }
    expose(:age_ranges) { AgeRange.all }

    expose(:playing_filmables) { Serie.current_playing.limit(20) }
    expose(:playing_soon_filmables) { Serie.playing_soon.limit(20) }
    expose(:featured_filmables) { Serie.featured(10) }
    expose(:available_netflix_filmables) { Serie.available_netflix.limit(20) }

    PER_PAGE = 50

    def index
      self.series = paginated_series
    end

    def show
      force_update = params[:force_update].present? && params[:force_update] == "true" ? true : false
      serie.api_transform(force_update)
    end

    private

    def resource
      serie
    end

    def resource_title
      serie.title
    end

    def index_path
      platform_series_index_path
    end

    def show_path
      platform_serie_path(resource)
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
end
