# frozen_string_literal: true

class NotificationsController < ApplicationController
  include NotificationsBreadcrumb

  # exposes
  expose(:notifications) { Notification.empty }

  def index
    self.notifications = paginated_notifications
  end

  private

  # Filtering

  def paginated_notifications
    notifications.page(params[:page]).per(PER_PAGE)
  end
end
