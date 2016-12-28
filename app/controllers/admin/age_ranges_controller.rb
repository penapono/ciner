# frozen_string_literal: true
module Admin
  class AgeRangesController < AdminController
    include Admin::AgeRangesBreadcrumb

    # exposes
    expose(:age_ranges) { AgeRange.all }
    expose(:age_range, attributes: :age_range_attributes)

    PER_PAGE = 10

    def index
      self.age_ranges = age_ranges.page(params[:page]).per(PER_PAGE)
    end

    private

    def resource
      age_range
    end

    def resource_title
      age_range.name
    end

    def index_path
      admin_age_ranges_path
    end

    def show_path
      admin_age_range_path(resource)
    end

    def age_range_params
      params.require(:age_range).permit(
        :name, :age
      )
    end

    def resource_params
      age_range_params
    end
  end
end
