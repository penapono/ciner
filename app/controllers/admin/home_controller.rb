# frozen_string_literal: true
class Admin::HomeController < AdminController
  expose(:user) { current_user }
  def index; end
end
