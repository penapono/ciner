# frozen_string_literal: true
module Admin
  class StudiosController < AdminController
    # exposes
    expose(:studios) { Studio.all }
    expose(:countries) { Country.all }
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
      admin_studios_path
    end

    def show_path
      admin_studio_path(resource)
    end

    def studio_params
      params.require(:studio).permit(
        :name, :country
      )
    end
  end
end
