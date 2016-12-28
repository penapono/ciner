# frozen_string_literal: true
module Admin
  class HomeController < AdminController
    expose(:user) { current_user }
    def index; end
  end
end
