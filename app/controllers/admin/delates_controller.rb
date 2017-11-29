# frozen_string_literal: true

module Admin
  class DelatesController < AdminController
    include Admin::DelatesBreadcrumb

    # exposes
    expose(:delates) { Delate.order(created_at: :desc) }
  end
end
