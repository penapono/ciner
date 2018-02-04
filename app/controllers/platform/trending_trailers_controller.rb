# frozen_string_literal: true

module Platform
  class TrendingTrailersController < PlatformController
    include Platform::TrendingTrailersBreadcrumb

    PER_PAGE = 10

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
      platform_trending_trailers_path
    end

    def show_path
      platform_trending_trailer_path(resource)
    end

    # Filtering

    def paginated_trending_trailers
      trending_trailers.page(params[:page]).per(PER_PAGE)
    end
  end
end
