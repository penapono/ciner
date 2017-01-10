# frozen_string_literal: true
module Platform
  class StudiosController < PlatformController
    include Platform::StudiosBreadcrumb

    # exposes
    expose(:studios) { Studio.all }
    expose(:studio, attributes: :studio_attributes)
    expose(:countries) { Country.all }
    expose(:states) { State.all }
    expose(:cities) { City.all }

    # Filters

    expose(:filtered_states) { filtered_states }
    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 10

    def index
      self.studios = paginated_studios
    end

    private

    def resource
      studio
    end

    def resource_title
      studio.name
    end

    def index_path
      platform_studios_path
    end

    def show_path
      platform_studio_path(resource)
    end

    def resource_params
      studio_params
    end

    def studio_params
      params.require(:studio).permit(
        :name, :country_id, :state_id, :city_id
      )
    end

    # Filtering

    def paginated_studios
      filtered_studio.page(params[:page]).per(PER_PAGE)
    end

    def filtered_studio
      studios.filter_by(searched_studios, params.fetch(:filter, ''))
    end

    def searched_studios
      studios.search(current_user, params.fetch(:search, ''))
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
