# frozen_string_literal: true

module Admin
  class TrendingTrailersController < AdminController
    include Admin::TrendingTrailersBreadcrumb

    PERMITTED_PARAMS = %i[
      title trailer
    ].freeze

    # exposes
    expose(:trending_trailers) { TrendingTrailer.order(created_at: :desc) }
    expose(:trending_trailer, attributes: :trending_trailer_attributes)

    def index
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
  end
end
