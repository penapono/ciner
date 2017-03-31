# frozen_string_literal: true
module Platform
  class CriticsController < PlatformController
    include Platform::CriticsBreadcrumb

    # exposes
    expose(:highlight) { highlight_critic }
    expose(:critics) { Critic.approved.all_but([highlight]) }
    expose(:critic, attributes: :critic_attributes)
    expose(:users) { User.all }

    PER_PAGE = 10

    def index
      return if critics.blank?
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
        :content, :user_id, :filmable_id, :filmable_type, :filmable, :rating
      )
    end

    # Filtering

    def highlight_critic
      Critic.all.filter_by(Critic.all, params.fetch(:filter, '')).highlight
    end

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
