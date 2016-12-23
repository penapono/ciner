# frozen_string_literal: true
module Admin
  class UsersController < AdminController
    before_action :clean_password, only: :update

    # exposes
    expose(:user, attributes: :user_params)
    expose(:users) { User.order(:name) }
    expose(:states) { State.order(:acronym).map(&:acronym) }
    expose(:cities) { user.city.state.cities if user.city }

    PER_PAGE = 15

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
      self.users = paginated_users
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

    def paginated_users
      searched_users.page(params[:page]).per(PER_PAGE)
    end

    def searched_users
      users.search(current_user, params.fetch(:search, ''))
    end

    def clean_password
      return unless params[:user].present? && params[:user][:password].blank?
      params[:user].delete(:password)
    end

    def user_params
      params.require(:user).permit(
        :name, :gender, :nickname, :birthday, :email, :cep, :address,
        :number, :neighbourhood, :city_id, :state_id, :cpf, :phone, :password,
        :password_confirmation, :role, :avatar, :biography, :mobile,
        :complement, :registered_at, :terms_of_use
      )
    end

    def resource_params
      user_params
    end
  end
end
