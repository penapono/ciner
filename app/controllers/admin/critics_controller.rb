# frozen_string_literal: true
module Admin
  class CriticsController < AdminController
    include Admin::CriticsBreadcrumb

    # exposes
    expose(:critics) { Critic.all }
    expose(:critic, attributes: :critic_attributes)
    expose(:movies) { Movie.first(20) }
    expose(:series) { Serie.first(20) }
    expose(:users) { User.all }

    PER_PAGE = 10

    before_filter :set_status, only: :update

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
        :content, :user_id, :filmable_id, :filmable_type, :filmable, :rating,
        :status, :origin
      )
    end

    # Approving, Reproving

    def set_status
      critic.status = :reproved
      critic.status = :approved if params[:approve]
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
