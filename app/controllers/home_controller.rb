class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to platform_root_path
    end
  end
end
