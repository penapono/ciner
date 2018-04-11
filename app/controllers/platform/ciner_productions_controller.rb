# frozen_string_literal: true

module Platform
  class CinerProductionsController < PlatformController
    include CinerProductionsBreadcrumb

    # exposes
    expose(:ciner_productions) { CinerProduction.approved }
    expose(:birthday_professionals) { User.birthdays }
    expose(:ciner_production, attributes: :ciner_production_attributes)

    PER_PAGE = 50

    def index
      self.ciner_productions = paginated_ciner_productions
    end

    def create
      resource.status = :pending
      if created?
        Notification.create(
          sender_id: resource.user_id,
          message: resource.id,
          receiver_id: User.find_by(nickname: "CINER").id,
          notification_type: :ciner_production_pending,
          answer: :waiting
        )
        redirect_to_index_with_success
      else
        render_new_with_error
      end
    end

    def update
      resource.status = :pending
      if updated?
        Notification.create(
          sender_id: resource.user_id,
          message: resource.id,
          receiver_id: User.find_by(nickname: "CINER").id,
          notification_type: :ciner_production_pending,
          answer: :waiting
        )
        redirect_to_index_with_success
      else
        render_edit_with_error
      end
    end

    private

    def resource
      ciner_production
    end

    def resource_title
      ciner_production.title
    end

    def index_path
      platform_ciner_productions_path
    end

    def show_path
      platform_ciner_production_path(resource)
    end

    def ciner_production_params
      params.require(:ciner_production).permit(
        :original_title,
        :title,
        :year,
        :length,
        :synopsis,
        :release,
        :brazilian_release,
        :age_range_id,
        :cover,
        :trailer,
        :playing,
        :playing_soon,
        :available_netflix,
        :available_amazon,
        :comments_count,
        :production_type,
        # Reacting
        :likes_count,
        :dislikes_count,
        :user,
        :deleted_at,
        :user_id,
        ciner_production_videos_attributes: %i[
          video
          season
          episode
          observation
          ciner_production_id
          id
          _destroy
        ],
        ciner_production_professionals_attributes: %i[
          curriculum_function_id
          user_id
          observation
          ciner_production_id
          id
          _destroy
        ],
        ciner_production_film_production_categories_attributes: %i[
          film_production_category_id
          ciner_production_id
          id
          _destroy
        ],
        ciner_production_countries_attributes: %i[
          country_id
          ciner_production_id
          id
          _destroy
        ]
      )
    end

    def resource_params
      ciner_production_params
    end

    # Filtering

    def paginated_ciner_productions
      filtered_ciner_production.page(params[:page]).per(PER_PAGE)
    end

    def filtered_ciner_production
      ciner_productions.filter_by(searched_ciner_productions, params.fetch(:filter, ''))
    end

    def searched_ciner_productions
      ciner_productions.search(current_user, params.fetch(:search, ''))
    end
  end
end
