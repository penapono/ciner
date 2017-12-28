# frozen_string_literal: true

class LogoController < ApplicationController
  layout false
  def index
    redirect_to home_path if current_user || (DateTime.now >= Time.zone.parse('2017-12-28 19:00'))
  end
end
