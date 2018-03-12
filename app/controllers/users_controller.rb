# frozen_string_literal: true

class UsersController < ApplicationController
  # exposes
  expose(:user)
  expose(:users) { User.order(:name) }
  expose(:states) { State.order(:acronym).collect(&:acronym) }
  expose(:cities) { user.city&.state&.cities }
  expose(:critics) { user.critics }
  expose(:user_collection) { user.user_collection }

  def update
    if user.update(user_params)
      if params[:user][:avatar].present?
        render :crop
      else
        AccountUpdateMailer
          .account_update_mail(user.email)
          .deliver_now
        redirect_to action: :show
      end
    else
      render :edit
    end
  end

  private

  def resource
    user
  end

  def index_path
    root_path
  end

  def user_params
    params.require(:user).permit(
      :name, :gender, :nickname, :birthday, :email, :cep, :address,
      :number, :neighbourhood, :city_id, :state_id, :country_id,
      :cpf, :phone, :password, :password_confirmation, :role, :avatar,
      :biography, :mobile, :complement, :registered_at, :terms_of_use, :age,
      :collection_privacy, :crop_x, :crop_y, :crop_w, :crop_h
    )
  end
end
