# frozen_string_literal: true

module Admin
  class SettingsController < AdminController
    expose(:user) { current_user }
  end
end
