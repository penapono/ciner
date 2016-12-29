# frozen_string_literal: true
module Admin
  class SetFunctionsController < AdminController
    include Admin::SetFunctionsBreadcrumb

    # exposes
    expose(:set_functions) { SetFunction.all }
    expose(:set_function, attributes: :set_function_attributes)

    PER_PAGE = 10

    def index
      self.set_functions = paginated_set_functions
    end

    private

    def resource
      set_function
    end

    def resource_title
      set_function.name
    end

    def index_path
      admin_set_functions_path
    end

    def show_path
      admin_set_function_path(resource)
    end

    def set_function_params
      params.require(:set_function).permit(
        :name, :description
      )
    end

    def resource_params
      set_function_params
    end

    # Filtering

    def paginated_set_functions
      filtered_set_function.page(params[:page]).per(PER_PAGE)
    end

    def filtered_set_function
      set_functions.filter_by(searched_set_functions, params.fetch(:filter, ''))
    end

    def searched_set_functions
      set_functions.search(current_user, params.fetch(:search, ''))
    end
  end
end
