# frozen_string_literal: true

module Admin
  class TrendingTrailersController < AdminController
    include Admin::TrendingTrailersBreadcrumb

    PER_PAGE = 15

    PERMITTED_PARAMS = %i[
      title
      trailer
      filmable_type
      filmable_id
    ].freeze

    # exposes
    expose(:trending_trailers) { TrendingTrailer.order(created_at: :desc).includes(:filmable) }
    expose(:trending_trailer, attributes: :trending_trailer_attributes)

    def index
      self.trending_trailers = paginated_trending_trailers
    end

    private

    def resource
      trending_trailer
    end

    def resource_title
      trending_trailer.title
    end

    def index_path
      admin_trending_trailers_path
    end

    def show_path
      admin_trending_trailer_path(resource)
    end

    def trending_trailer_params
      params.require(:trending_trailer).permit(PERMITTED_PARAMS)
    end

    def resource_params
      trending_trailer_params
    end

    # Filtering

    def paginated_trending_trailers
      trending_trailers.page(params[:page]).per(PER_PAGE)
    end
  end
end
