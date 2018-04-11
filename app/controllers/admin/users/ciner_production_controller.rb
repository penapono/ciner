# frozen_string_literal: true

module Admin
  module Users
    class CinerProductionController < AdminController
      # exposes
      expose(:user)
      expose(:filmables) { user.ciner_productions }
    end
  end
end
