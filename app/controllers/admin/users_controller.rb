# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Admin::UsersBreadcrumb

    before_action :clean_password, only: :update

    # exposes
    expose(:user, attributes: :user_params)
    expose(:users) { User.all }
    expose(:states) { State.order(:acronym).map(&:acronym) }
    expose(:cities) { user.city.state.cities if user.city }
    expose(:critics) { user.critics }
    expose(:user_collection) { user.user_collection }

    # Filters

    expose(:filtered_cities) { filtered_cities }

    PER_PAGE = 10

    def index
      self.users = paginated_users
    end

    def show
      self.user = current_user
    end

    private

    def resource
      user
    end

    def resource_title
      user.name
    end

    def index_path
      admin_users_path
    end

    def show_path
      admin_user_path(resource)
    end

    def clean_password
      return unless params[:user].present? && params[:user][:password].blank?
      params[:user].delete(:password)
    end

    def user_params
      params.require(:user).permit(
        :name, :gender, :nickname, :birthday, :email, :cep, :address,
        :number, :neighbourhood, :city_id, :state_id, :country_id,
        :cpf, :phone, :password, :password_confirmation, :role, :avatar,
        :biography, :mobile, :complement, :registered_at, :terms_of_use, :age
      )
    end

    def resource_params
      user_params
    end

    # Filtering

    def paginated_users
      filtered_user.page(params[:page]).per(PER_PAGE)
    end

    def filtered_user
      users.filter_by(searched_users, params.fetch(:filter, ''))
    end

    def searched_users
      users.search(current_user, params.fetch(:search, ''))
    end

    # Filters

    def filtered_cities
      return unless params[:filter] && params[:filter][:state].present?
      State.find(params[:filter][:state]).cities
    end
  end
end
