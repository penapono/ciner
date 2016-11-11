class Platform::UsersController < PlatformController
  # exposes
  expose(:user) { current_user }
  expose(:users) { User.order(:name) }
  expose(:states) { State.order(:acronym).map(&:acronym) }
  expose(:cities) { City.where(state: states.first) if states.any? }

  def show
  end

  def edit
  end

  def update
    if user.update(user_params)
      flash.notice = t('.success')
      redirect_to action: :show
    else
      flash.alert = t('.failure')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :gender, :nickname, :birthday, :email, :cep, :address,
      :neighbourhood, :city_id, :cpf, :phone, :password,
      :password_confirmation, :role, :avatar, :biography
    )
  end
end
