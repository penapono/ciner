# frozen_string_literal: true

module Admin
  class BannersController < AdminController
    include Admin::BannersBreadcrumb

    PER_PAGE = 10

    PERMITTED_PARAMS = %i[
      title link image position visible
    ].freeze

    # exposes
    expose(:banners) { Banner.all }
    expose(:banner, attributes: :banner_attributes)

    def index
      self.banners = paginated_banners
    end

    private

    def resource
      banner
    end

    def resource_title
      banner.title
    end

    def index_path
      admin_banners_path
    end

    def show_path
      admin_banner_path(resource)
    end

    def banner_params
      params.require(:banner).permit(PERMITTED_PARAMS)
    end

    def resource_params
      banner_params
    end

    # Filtering

    def paginated_banners
      filtered_banner.page(params[:page]).per(PER_PAGE)
    end

    def filtered_banner
      banners.filter_by(searched_banners, params.fetch(:filter, ''))
    end

    def searched_banners
      banners.search(current_user, params.fetch(:search, ''))
    end
  end
end
