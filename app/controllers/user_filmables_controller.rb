# frozen_string_literal: true

class UserFilmablesController < ApplicationController
  expose(:user_filmable, attributes: :user_filmable_attributes)

  respond_to :html, :js
  layout false

  def index; end

  def show; end

  def edit; end

  def destroy
    user_filmable.destroy
    redirect_to :back
  end

  def user_filmable_params
      params.require(:user_filmable).permit(
        :store
      )
    end

    def resource_params
      user_filmable_params
    end
end
