# frozen_string_literal: true

module Platform
  module Users
    class CinerProductionController < PlatformController
      # exposes
      expose(:user)
      expose(:filmables) { user.ciner_productions }
    end
  end
end
