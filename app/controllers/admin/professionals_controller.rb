# frozen_string_literal: true
module Admin
  class ProfessionalsController < AdminController
    # exposes
    expose(:professionals) { Professional.all }
    expose(:professional, attributes: :professional_attributes)

    expose(:countries) { Country.all }
    expose(:set_functions) { SetFunction.all }

    PER_PAGE = 10

    def index
      self.professionals = professionals.page(params[:page]).per(PER_PAGE)
    end

    private

    def resource
      professional
    end

    def resource_title
      professional.name
    end

    def index_path
      admin_professionals_path
    end

    def show_path
      admin_professional_path(resource)
    end

    def professional_params
      params.require(:professional).permit(
        :name, :birth, :country_id, :user, :set_function_id
      )
    end

    def resource_params
      professional_params
    end
  end
end
