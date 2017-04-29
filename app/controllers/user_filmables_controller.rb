# frozen_string_literal: true

class UserFilmablesController < ApplicationController
  expose(:user_filmable)

  respond_to :html, :js
  layout false

  def index; end

  def show; end

  def destroy
    user_filmable.destroy
    redirect_to :back
  end
end
