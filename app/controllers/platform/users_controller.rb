class Platform::UsersController < PlatformController
  expose(:user) { current_user }

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
    params.require(:user).permit(:password)
  end
end
