# frozen_string_literal: true
class AdminController < ApplicationController
  before_action :check_admin

  layout 'admin'

  def check_admin
    authenticate_user!
    redirect_to root_path unless user_signed_in? && current_user.admin?
  end
end
