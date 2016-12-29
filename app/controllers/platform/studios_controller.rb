# frozen_string_literal: true
module Admin
  class StudiosController < AdminController
    include Platform::StudiosBreadcrumb

    # exposes
    expose(:studios) { Studio.all }
    expose(:countries) { Country.all }
    expose(:states) { Country.all }
    expose(:cities) { Country.all }
    expose(:studio, attributes: :studio_attributes)

    PER_PAGE = 10

    def index
      self.studios = studios.page(params[:page]).per(PER_PAGE)
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
  end
end
