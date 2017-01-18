# frozen_string_literal: true
module Platform
  class CriticsController < PlatformController
    include Platform::CriticsBreadcrumb

    # exposes
    expose(:critics) { Critic.all }
    expose(:critic, attributes: :critic_attributes)

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
      platform_critics_path
    end

    def show_path
      platform_critic_path(resource)
    end

    def resource_params
      critic_params
    end

    def critic_params
      params.require(:critic).permit(
        :name, :country_id, :state_id, :city_id
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
  end
end
