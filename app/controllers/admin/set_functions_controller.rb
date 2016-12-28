# frozen_string_literal: true
module Admin
  class SetFunctionsController < AdminController
    include Admin::SetFunctionsBreadcrumb

    # exposes
    expose(:set_functions) { SetFunction.all }
    expose(:set_function, attributes: :set_function_attributes)

    PER_PAGE = 10

    def index
      self.set_functions = set_functions.page(params[:page]).per(PER_PAGE)
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
  end
end
