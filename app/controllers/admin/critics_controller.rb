# frozen_string_literal: true
module Admin
  class CriticsController < AdminController
    include Admin::CriticsBreadcrumb

    # exposes
    expose(:critics) { Critic.all }
    expose(:critic, attributes: :critic_attributes)
    expose(:countries) { Country.all }
    expose(:states) { State.all }
    expose(:cities) { City.all }
    expose(:movies) { Movie.first(20) }
    expose(:series) { Serie.first(20) }

    # Filters

    expose(:filtered_states) { filtered_states }
    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 10

    def index
      self.critics = paginated_critics
    end

    private

    def resource
      critic
    end

    def resource_title
      critic.name
    end

    def index_path
      admin_critics_path
    end

    def show_path
      admin_critic_path(resource)
    end

    def resource_params
      critic_params
    end

    def critic_params
      params.require(:critic).permit(
        :name, :content, :user_id, :country_id, :state_id, :city_id,
        :filmable_id, :filmable_type, :filmable
      )
    end

    # Filtering

    def paginated_critics
      filtered_critic.page(params[:page]).per(PER_PAGE)
    end

    def filtered_critic
      critics.filter_by(searched_critics, params.fetch(:filter, ''))
    end

    def searched_critics
      critics.search(current_user, params.fetch(:search, ''))
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
