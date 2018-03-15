# frozen_string_literal: true

# customize registration controller
class RegistrationsController < Devise::RegistrationsController
  layout 'application'
  skip_before_action :require_no_authentication
  before_action :resource_name

  # exposes
  expose(:user, attributes: :user_params)
  expose(:states) { State.order(:acronym).map(&:acronym) }
  expose(:cities) { user.city&.state&.cities }

  def resource_name
    :user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @accepted = (params[:user][:terms_of_use] == "1")
    if verify_recaptcha(model: @user) || Rails.env.development?
      super
    else
      render :new
    end
  end

  def update
    byebug
    AccountUpdateMailer
            .account_update_mail(user.email)
            .deliver_now
    super
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :gender, :nickname, :birthday, :email, :cep, :address,
      :number, :neighbourhood, :city_id, :state_id, :cpf, :phone, :password,
      :password_confirmation, :role, :avatar, :biography, :mobile,
      :complement, :registered_at, :terms_of_use, :crop_x, :crop_y, :crop_w, :crop_h
    )
  end
end
