# frozen_string_literal: true
class PlatformController < ApplicationController
  before_filter :check_admin

  layout 'platform'

  def check_admin
    authenticate_user!
    redirect_to root_path unless user_signed_in?
  end
end
