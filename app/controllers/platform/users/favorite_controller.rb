# frozen_string_literal: true

module Platform
  module Users
    class FavoriteController < ApplicationController
      # exposes
      expose(:user)
      expose(:filmables) { user.user_favorite }
    end
  end
end
