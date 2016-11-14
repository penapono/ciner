module Admin
  class UsersController < AdminController
    before_action :clean_password, only: :update

    # exposes
    expose(:user, attributes: :user_params)
    expose(:users) { User.order(:name) }
    expose(:states) { State.order(:acronym).map(&:acronym) }
    expose(:cities) { City.where(state: states.first) if states.any? }

    def new
    end

    def create
      if user.save
        flash.notice = t('.success')
        redirect_to action: :index
      else
        flash.alert = t('.failure')
        render :new
      end
    end

    def index
      self.users = users.page(params[:page]).per(15)
    end

    def edit
    end

    def update
      if user.save
        flash.notice = t('.success')
        redirect_to action: :show
      else
        flash.alert = t('.failure')
        render :edit
      end
    end

    def show
    end

    def destroy
      if user.destroy
        flash.notice = t('.success')
      else
        flash.alert = t('.failure')
      end
      redirect_to action: :index
    end

    private

    def clean_password
      return unless params[:user].present? && params[:user][:password].blank?
      params[:user].delete(:password)
    end

    def user_params
      params.require(:user).permit(
        :name, :gender, :nickname, :birthday, :email, :cep, :address,
        :neighbourhood, :city_id, :cpf, :phone, :password,
        :password_confirmation, :role, :avatar, :biography
      )
    end
  end
end
