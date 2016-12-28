# frozen_string_literal: true
module Admin
  class FilmProductionCategoriesController < AdminController
    include Platform::FilmProductionCategoriesBreadcrumb

    # exposes
    expose(:film_production_categories) { FilmProductionCategory.all }
    expose(:film_production_category, attributes: :film_production_category_attributes)

    PER_PAGE = 10

    def index
      self.film_production_categories =
        film_production_categories.page(params[:page]).per(PER_PAGE)
    end

    private

    def resource
      film_production_category
    end

    def resource_title
      film_production_category.name
    end

    def index_path
      platform_film_production_categories_path
    end

    def show_path
      platform_film_production_category_path(resource)
    end

    def film_production_category_params
      params.require(:film_production_category).permit(
        :name, :description
      )
    end

    def resource_params
      film_production_category_params
    end
  end
end
