# frozen_string_literal: true

module Platform
  module Users
    class WatchedController < ApplicationController
      # exposes
      expose(:user)
      expose(:filmables) { user.user_watched }
    end
  end
end
