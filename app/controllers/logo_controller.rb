# frozen_string_literal: true

class LogoController < ApplicationController
  layout false
  def index
    redirect_to platform_root_path if current_user
  end
end
