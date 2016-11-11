class ApplicationController < ActionController::Base
  include ::BaseController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :name, :gender, :nickname, :birthday, :email, :cep, :address,
        :number, :neighbourhood, :city_id, :state_id, :cpf, :phone, :password,
        :password_confirmation, :role, :avatar, :biography
      ])
  end
end
