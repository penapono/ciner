# customize registration controller
class RegistrationsController < Devise::RegistrationsController
  layout 'application'
  skip_before_filter :require_no_authentication
  before_filter :resource_name

  # exposes
  expose(:user, attributes: :user_params)
  expose(:states) { State.order(:acronym).map(&:acronym) }
  expose(:cities) { City.where(state: states.first) if states.any? }

  def resource_name
    :user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @accepted = (params[:user][:terms_of_use] == "1")
    # byebug
    # if verify_recaptcha(model: @user)
      super
    # else
    #   render :new
    # end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :gender, :nickname, :birthday, :email, :cep, :address,
      :number, :neighbourhood, :city_id, :state_id, :cpf, :phone, :password,
      :password_confirmation, :role, :avatar, :biography, :mobile,
      :complement, :registered_at, :terms_of_use
    )
  end
end
