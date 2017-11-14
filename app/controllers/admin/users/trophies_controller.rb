# frozen_string_literal: true

module Admin
  module Users
    class TrophiesController < ApplicationController
      # exposes
      expose(:user)
      expose(:trophies) { Trophy.all }

      def index; end
    end
  end
end
