# frozen_string_literal: true

class ProfessionalsController < ApplicationController
  include ProfessionalsBreadcrumb

  # exposes
  expose(:professionals) { Professional.all }
  expose(:movies) { Movie.where(id: FilmableProfessional.where(filmable_type: 'Movie', professional_id: professional.id, set_function_id: SetFunction.find_by(name: 'Elenco')).pluck(:filmable_id)) }
  expose(:professional, attributes: :professional_attributes)
  expose(:broadcasts) { professional.broadcasts }

  expose(:set_functions) { SetFunction.all }

  # Filters

  expose(:filtered_states) { filtered_states }
  expose(:filtered_cities) { filtered_cities }

  PER_PAGE = 10

  def index
    self.professionals = professionals.page(params[:page]).per(PER_PAGE)
  end

  def show
    professional.api_transform
  end

  private

  def resource
    professional
  end

  def resource_title
    professional.name
  end

  def index_path
    platform_professionals_path
  end

  def show_path
    platform_professional_path(resource)
  end

  def professional_params
    params.require(:professional).permit(
      :name, :birth, :country_id, :user, :set_function_id
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
    professionals.search(current_user, params.fetch(:search, ''))
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
