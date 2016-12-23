# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    redirect_to platform_root_path if user_signed_in?
  end
end
