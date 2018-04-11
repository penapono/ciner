# frozen_string_literal: true

module Users
  class CinerProductionController < ApplicationController
    # exposes
    expose(:user)
    expose(:filmables) { user.ciner_productions }
  end
end
