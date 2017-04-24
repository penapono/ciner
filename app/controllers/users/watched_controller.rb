# frozen_string_literal: true

module Users
  class WatchedController < ApplicationController
    # exposes
    expose(:user)
    expose(:filmables) { user.user_watched }
  end
end
