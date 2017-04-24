# frozen_string_literal: true

module Admin
  module Users
    class FavoriteController < ApplicationController
      # exposes
      expose(:user)
      expose(:filmables) { user.user_favorite }
    end
  end
end
