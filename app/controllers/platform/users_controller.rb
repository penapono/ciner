# frozen_string_literal: true

module Platform
  class UsersController < PlatformController
    # exposes
    expose(:user)
    expose(:users) { User.order(:name) }
    expose(:states) { State.order(:acronym).collect(&:acronym) }
    expose(:cities) { user.city&.state&.cities }
    expose(:critics) { user.critics }
    expose(:user_collection) { user.user_collection }

    def show; end

    def edit; end

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
        :number, :neighbourhood, :city_id, :state_id, :country_id,
        :cpf, :phone, :password, :password_confirmation, :role, :avatar,
        :biography, :mobile, :complement, :registered_at, :terms_of_use, :age,
        :collection_privacy
      )
    end
  end
end
