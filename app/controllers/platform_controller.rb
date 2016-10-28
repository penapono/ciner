class PlatformController < ApplicationController
  before_filter :check_admin

  layout 'platform'

  def check_admin
    authenticate_user!
    redirect_to admin_root_path if user_signed_in? && current_user.admin?
  end
end
