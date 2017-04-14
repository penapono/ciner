# frozen_string_literal: true

class HomeController < ApplicationController
  include ::HomeContentsController

  def index
    redirect_to platform_root_path if user_signed_in?
  end
end
