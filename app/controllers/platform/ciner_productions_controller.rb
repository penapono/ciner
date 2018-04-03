# frozen_string_literal: true

module Platform
  class CinerProductionsController < PlatformController
    include CinerProductionsBreadcrumb

    # exposes
    expose(:ciner_productions) { CinerProduction.all }
    expose(:birthday_professionals) { User.birthdays }
    expose(:ciner_production, attributes: :ciner_production_attributes)

    PER_PAGE = 50

    def index
      self.ciner_productions = paginated_ciner_productions
    end

    private

    def resource
      ciner_production
    end

    def resource_title
      ciner_production.title
    end

    def index_path
      ciner_productions_path
    end

    def show_path
      ciner_production_path(resource)
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
        :omdb_genre,
        :omdb_rated,
        :trailer,
        :countries,
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
