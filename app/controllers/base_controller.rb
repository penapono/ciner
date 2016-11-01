module ::BaseController
  extend ActiveSupport::Concern

  FIND_ACTIONS = [:show, :edit, :update, :destroy]

  BASE_HELPER_METHODS = [:breadcrumbs, :javascript, :stylesheet]

  included do
    helper_method BASE_HELPER_METHODS

    # helper methods

    def javascript
      "views/#{controller_path}/#{action_name}"
    end

    def stylesheet
      "views/#{controller_path}/#{action_name}"
    end
  end

  def find_action?
    FIND_ACTIONS.include?(action_name.to_sym)
  end
end
