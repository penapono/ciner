# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper :all
  include ::BaseController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery prepend: true, with: :exception
  # before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[
        name gender nickname birthday email cep address
        number neighbourhood city_id state_id country_id
        cpf phone password password_confirmation role avatar
        biography mobile complement registered_at terms_of_use age
        collection_privacy provider uid
      ]
    )
  end
end
