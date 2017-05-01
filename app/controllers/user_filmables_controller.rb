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

  def new
    @filmable_id = params[:filmable_id]
    @filmable_type = params[:filmable_type]

    super
  end

  def redirect_to_index_with_success
    redirect_to :back
  end

  def resource
    user_filmable
  end

  def resource_title
    user_filmable.filmable.title
  end

  def show_path
    :back
  end

  def user_filmable_params
    params.require(:user_filmable).permit(
      :user_id,
      :filmable_type,
      :filmable_id,
      :action,
      :created_at,
      :updated_at,
      :media,
      :version,
      :position,
      :store,
      :gift,
      :price,
      :bought,
      :isbn,
      :borrowed,
      :observation,
      :cover
    )
  end

  def resource_params
    user_filmable_params
  end
end
