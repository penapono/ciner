# frozen_string_literal: true

module Admin
  class CurriculumFunctionsController < AdminController
    include Admin::CurriculumFunctionsBreadcrumb

    # exposes
    expose(:curriculum_functions) { CurriculumFunction.all }
    expose(:curriculum_function, attributes: :curriculum_function_attributes)

    PER_PAGE = 10

    def index
      self.curriculum_functions = paginated_curriculum_functions
    end

    private

    def resource
      curriculum_function
    end

    def resource_title
      curriculum_function.name
    end

    def index_path
      admin_curriculum_functions_path
    end

    def show_path
      admin_curriculum_function_path(resource)
    end

    def curriculum_function_params
      params.require(:curriculum_function).permit(
        :name, :description
      )
    end

    def resource_params
      curriculum_function_params
    end

    # Filtering

    def paginated_curriculum_functions
      filtered_curriculum_function.page(params[:page]).per(PER_PAGE)
    end

    def filtered_curriculum_function
      curriculum_functions.filter_by(searched_curriculum_functions, params.fetch(:filter, ''))
    end

    def searched_curriculum_functions
      curriculum_functions.search(current_user, params.fetch(:search, ''))
    end
  end
end
