# frozen_string_literal: true

module Admin
  class DuplicateProfessionalsController < AdminController
    include Admin::ProfessionalsBreadcrumb

    # exposes
    expose(:professionals) { Professional.where(name: nil).includes(:set_function) }
    expose(:professional, attributes: :professional_attributes)
    expose(:broadcasts) { professional.broadcasts }

    expose(:set_functions) { SetFunction.all }

    # Filters
    PER_PAGE = 10

    def index
      self.professionals = paginated_professionals
    end

    def show
      force_update = params[:force_update].present? && params[:force_update] == "true" ? true : false
      professional.api_transform(force_update)
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
        :name, :birthday, :deathday, :country_id, :user, :set_function_id,
        :gender, :avatar, :biography, :lock_updates, :place_of_birth
      )
    end

    def resource_params
      professional_params
    end

    # Filtering

    def paginated_professionals
      filtered_professional.page(params[:page]).per(PER_PAGE)
    end

    def filtered_professional
      professionals.filter_by(searched_professionals, params.fetch(:filter, ''))
    end

    def searched_professionals
      professionals
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
