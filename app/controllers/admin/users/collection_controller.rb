# frozen_string_literal: true

module Admin
  module Users
    class CollectionController < ApplicationController
      # exposes
      expose(:user)
      expose(:filmables) { user.user_collection }
    end
  end
end
