# frozen_string_literal: true
module Admin
  class FilmProductionsController < AdminController
    include Admin::FilmProductionsBreadcrumb

    # exposes
    expose(:film_productions) { FilmProduction.all }
    expose(:film_production, attributes: :film_production_attributes)

    expose(:film_production_categories) { FilmProductionCategory.all }
    expose(:countries) { Country.all }
    expose(:age_ranges) { AgeRange.all }

    # Filters

    expose(:filtered_states) { filtered_states }
    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 10

    def index
      self.film_productions = paginated_film_productions
    end

    private

    def resource
      film_production
    end

    def resource_title
      film_production.title
    end

    def index_path
      admin_film_productions_path
    end

    def show_path
      admin_film_production_path(resource)
    end

    def film_production_params
      params.require(:film_production).permit(
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

        # Movie / Serie / CinerMovie

        :type,

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
      film_production_params
    end

    # Filtering

    def paginated_film_productions
      filtered_film_production.page(params[:page]).per(PER_PAGE)
    end

    def filtered_film_production
      film_productions.filter_by(searched_film_productions, params.fetch(:filter, ''))
    end

    def searched_film_productions
      film_productions.search(current_user, params.fetch(:search, ''))
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
